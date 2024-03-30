resource "aws_cognito_user_pool" "this" {
  name = var.user_pool_name

  account_recovery_setting {
    recovery_mechanism {
      name     = "verified_email"
      priority = 1
    }
  }

  password_policy {
    minimum_length                   = 8
    require_uppercase                = true
    require_numbers                  = true
    require_lowercase                = true
    require_symbols                  = true
    temporary_password_validity_days = var.temp_pass_validity_days
  }

  verification_message_template {
    email_message = var.email_verification_template
    email_subject = var.email_subject_template
    sms_message = var.email_verification_template
  }

  email_configuration {
    email_sending_account = "COGNITO_DEFAULT"
  }

  admin_create_user_config {
    allow_admin_create_user_only = false
    invite_message_template {
      email_message = var.invite_email_template
      email_subject = var.invite_subject_template
      sms_message = var.invite_email_template
    }
  }

  username_configuration {
    case_sensitive = true
  }

  username_attributes = ["email"]

  schema {
    mutable             = false
    attribute_data_type = "String"
    required            = false
    name                = "document"
    string_attribute_constraints {
      min_length = 11
      max_length = 14
    }
  }

  tags = local.tags_default
}

resource "aws_cognito_user_pool_domain" "this" {
  domain       = "app-teste-lucas"
  user_pool_id = aws_cognito_user_pool.this.id
}

resource "aws_cognito_user_pool_client" "this" {
  user_pool_id                         = aws_cognito_user_pool.this.id
  name                                 = "dotnet-dojo-api-client"
  access_token_validity                = 60
  id_token_validity                    = 1
  refresh_token_validity               = 30
  prevent_user_existence_errors        = "ENABLED"
  allowed_oauth_flows_user_pool_client = true
  enable_token_revocation              = true
  allowed_oauth_scopes                 = ["email", "profile", "openid"]
  allowed_oauth_flows                  = ["code"]
  explicit_auth_flows                  = ["ALLOW_USER_PASSWORD_AUTH", "ALLOW_REFRESH_TOKEN_AUTH", "ALLOW_USER_PASSWORD_AUTH"]
  supported_identity_providers         = ["COGNITO"]
  callback_urls                        = ["https://localhost:5001/signin-oidc"]
  generate_secret                      = true
  token_validity_units {
    access_token  = "minutes"
    id_token      = "days"
    refresh_token = "days"
  }
}
