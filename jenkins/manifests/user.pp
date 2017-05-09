define jenkins::user (
  $email,
  $password,
  $full_name = 'Managed by Puppet',
  $public_key = '',
  $ensure = 'present',
){
  validate_re($ensure, '^present$|^absent$')

  include ::jenkins::cli_helper

  Class['jenkins::cli_helper'] ->
    Jenkins::User[$title] ->
      Anchor['jenkins::end']

  case $ensure {
    'present': {
      validate_re($email, '^[^@]+@[^@]+$', "An email address is required, not '${email}'")
      validate_string($password)
      validate_string($full_name)
      validate_string($public_key)
      # XXX not idempotent
      jenkins::cli::exec { "create-jenkins-user-${title}":
        command => [
          'create_or_update_user',
          $title,
          $email,
          "'${password}'",
          "'${full_name}'",
          "'${public_key}'",
        ],
      }
    }
    'absent': {
      # XXX not idempotent
      jenkins::cli::exec { "delete-jenkins-user-${title}":
        command => [
          'delete_user',
          $title,
        ],
      }
    }
    default: {
      fail "ensure must be 'present' or 'absent' but '${ensure}' was given"
    }
  }
}