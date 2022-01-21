#
# @summary Install Helm binary
#
# @param version
#   Helm release version
#
# @param checksum
#   Artifact checksum string
#
# @param checksum_type
#   The digest algorithm used for the checksum string.
#
# @param base_path
#   Base path under which to install software.
#
class helm_binary (
  String $version                 = '3.7.2',
  String $checksum                = '4ae30e48966aba5f807a4e140dad6736ee1a392940101e4d79ffb4ee86200a9e',
  String $checksum_type           = 'sha256',
  Stdlib::Absolutepath $base_path = '/opt/helm',
) {
  $cmd                  = 'helm'
  $bin_path             = '/usr/bin'
  $version_path         = "${base_path}/${version}"
  $dl_path              = "${version_path}/dl"
  $extract_path         = "${version_path}/bin"

  $uname        = 'linux'
  $arch         = 'amd64'
  $base_url     = 'https://get.helm.sh'
  $archive_file = "${cmd}-v${version}-${uname}-${arch}.tar.gz"

  $source       = "${base_url}/${archive_file}"
  $dest_archive = "${dl_path}/${archive_file}"
  $dest_cmd     = "${extract_path}/${cmd}"

  file { [$base_path, $version_path, $dl_path, $extract_path]:
    ensure => directory,
    owner  => 'root',
    group  => 'root',
    mode   => '0755',
  }

  archive { $cmd:
    ensure          => present,
    checksum        => $checksum,
    checksum_type   => $checksum_type,
    cleanup         => false,
    creates         => $dest_cmd,
    extract_path    => $extract_path,
    extract_command => "tar -x -C ${extract_path} --strip-components=1 -f %s ${uname}-${arch}/${cmd}",
    extract         => true,
    path            => $dest_archive,
    source          => $source,
    require         => File[$dl_path, $extract_path],
  }

  file { $dest_cmd:
    ensure  => file,
    owner   => 'root',
    group   => 'root',
    mode    => '0755',
    require => Archive[$cmd],
  }

  file { "${bin_path}/${cmd}":
    ensure  => link,
    target  => $dest_cmd,
    require => Archive[$cmd],
  }
}
