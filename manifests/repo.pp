# Class: helm_binary::repo
#
# @param debian_apt_source apt details of the repo, see hiera
#
class helm_binary::repo (
  Hash $debian_apt_source = {},
) {
  case fact('os.family') {
    'Debian': {
      unless empty($debian_apt_source) {
        apt::source { 'helm':
          * => $debian_apt_source,
        }

        Class['apt::update'] -> Package <| provider == 'apt' |>
      }
    }
    default: {}
  }
}
