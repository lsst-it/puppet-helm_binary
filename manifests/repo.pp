# Class: helm_binary::repo
#
# @param debian_apt_source apt details of the repo, see hiera
#
class helm_binary::repo (
  String $debian_apt_source,
) {
  case fact('os.family') {
    'Debian': {
      apt::source { 'helm':
        * => $debian_apt_source,
      }
    }
    default: {
      notify { "OS family #{fact('os.family')} not supported": }
    }
  }
}
