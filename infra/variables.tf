variable "user_pool_name" {
  type    = string
  default = "dotnet-dojo"
}

variable "email_verification_template" {
  type    = string
  default = "O seu código de verificação é {####}"
}

variable "email_subject_template" {
  type    = string
  default = "Seu código de confirmação chegou!"
}

variable "temp_pass_validity_days" {
  type    = number
  default = 2
}

variable "invite_email_template" {
  type    = string
  default = "Você acaba de ser convidado a participar de um app teste. Seu usuário é {username} e sua senha é {####}"
}

variable "invite_subject_template" {
  type    = string
  default = "Bem-vindo(a) ao App Teste"
}