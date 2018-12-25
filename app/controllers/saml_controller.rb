# frozen_string_literal: true

class SamlController < ActionController::Base
  def index
  end

  def sso
    redirect_to(OneLogin::RubySaml::Authrequest.new.create(saml_settings))
  end

  def acs
    res = OneLogin::RubySaml::Response.new(params[:SAMLResponse], settings: saml_settings)

    if res.is_valid?
      session[:nameid] = res.nameid
      session[:attributes] = res.attributes
      @attrs = session[:attributes]

      logger.info "Sucessfully logged"
      logger.info "NAMEID: #{res.nameid}"

      render action: :index
    else
      logger.info "Response Invalid. Errors: #{res.errors}"

      @errors = res.errors

      render action: :fail
    end
  end

  def metadata
    render xml: OneLogin::RubySaml::Metadata.new.generate(saml_settings, true)
  end

  # Trigger SP and IdP initiated Logout requests
  def logout
    # If we're given a logout request, handle it in the IdP logout initiated method
    if params[:SAMLRequest]
      return idp_logout_request
    # We've been given a response back from the IdP
    elsif params[:SAMLResponse]
      return process_logout_response
    elsif params[:slo]
      return sp_logout_request
    else
      reset_session
    end
  end

  private

  # Create an SP initiated SLO
  def sp_logout_request
    # LogoutRequest accepts plain browser requests w/o paramters
    if saml_settings.idp_slo_target_url.nil?
      logger.info "SLO IdP Endpoint not found in settings, executing then a normal logout'"

      reset_session
    else
      # Since we created a new SAML request, save the transaction_id
      # to compare it with the response we get back
      logout_request = OneLogin::RubySaml::Logoutrequest.new()
      session[:transaction_id] = logout_request.uuid

      logger.info "New SP SLO for User ID: '#{session[:nameid]}', Transaction ID: '#{session[:transaction_id]}'"

      if saml_settings.name_identifier_value.nil?
        saml_settings.name_identifier_value = session[:nameid]
      end

      relayState = url_for controller: 'saml', action: 'index'

      redirect_to(logout_request.create(settings, RelayState: relayState))
    end
  end

  # After sending an SP initiated LogoutRequest to the IdP, we need to accept
  # the LogoutResponse, verify it, then actually delete our session.
  def process_logout_response
    request_id = session[:transaction_id]
    logout_response = OneLogin::RubySaml::Logoutresponse.new(params[:SAMLResponse], saml_settings, matches_request_id: request_id, get_params: params)

    logger.info "LogoutResponse is: #{logout_response.response.to_s}"

    # Validate the SAML Logout Response
    if not logout_response.validate
      error_msg = "The SAML Logout Response is invalid.  Errors: #{logout_response.errors}"
      logger.error error_msg

      render inline: error_msg
    else
      # Actually log out this session
      if logout_response.success?
        logger.info "Delete session for '#{session[:nameid]}'"

        reset_session
      end
    end
  end

  # Method to handle IdP initiated logouts
  def idp_logout_request
    logout_request = OneLogin::RubySaml::SloLogoutrequest.new(params[:SAMLRequest], settings: saml_settings)

    unless logout_request.is_valid?
      error_msg = "IdP initiated LogoutRequest was not valid!. Errors: #{logout_request.errors}"
      logger.error error_msg

      render inline: error_msg
    end

    logger.info "IdP initiated Logout for #{logout_request.nameid}"

    # Actually log out this session
    reset_session

    redirect_to OneLogin::RubySaml::SloLogoutresponse.new.create(saml_settings, logout_request.id, nil, RelayState: params[:RelayState])
  end

  def saml_settings
    # this is just for testing purposes.
    # should retrieve SAML-settings based on subdomain, IP-address, NameID or similar
    @saml_settings ||= OneLogin::RubySaml::Settings.new.tap do |settings|
      url_base = 'http://localhost:3000'

      # When disabled, saml validation errors will raise an exception.
      settings.soft = false

      # SP section
      settings.issuer = 'spn:86c025e8-b9dd-4a2e-b3d5-f1b87ba7ad28'
      settings.assertion_consumer_service_url = url_base + '/saml/acs'
      settings.assertion_consumer_logout_service_url = url_base + '/saml/logout'

      # IdP section
      settings.idp_entity_id = 'https://sts.windows.net/c865db3f-e8a7-47cf-8b31-7c76b11eabef/'
      settings.idp_sso_target_url = 'https://login.microsoftonline.com/c865db3f-e8a7-47cf-8b31-7c76b11eabef/saml2'
      settings.idp_slo_target_url = ''
      settings.idp_cert = ''

      # settings.idp_cert_fingerprint = ''
      # settings.idp_cert_fingerprint_algorithm = XMLSecurity::Document::SHA1

      settings.name_identifier_format = "urn:oasis:names:tc:SAML:1.1:nameid-format:emailAddress"

      # Security section
      settings.security[:authn_requests_signed] = false
      settings.security[:logout_requests_signed] = false
      settings.security[:logout_responses_signed] = false
      settings.security[:metadata_signed] = false
      settings.security[:digest_method] = XMLSecurity::Document::SHA1
      settings.security[:signature_method] = XMLSecurity::Document::RSA_SHA1
    end
  end
end
