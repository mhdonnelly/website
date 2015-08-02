#
# Copyright (C) 2013-2014   Ian Firns   <firnsy@kororaproject.org>
#                           Chris Smart <csmart@kororaproject.org>
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU Affero General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU Affero General Public License for more details.
#
# You should have received a copy of the GNU Affero General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.
#
package Website::Download;

use warnings;
use strict;

use Mojo::Base 'Mojolicious::Controller';

#
# PERL INCLUDES
#
use Data::Dumper;
use Mojo::JSON qw(encode_json);

#
# CONSTANTS
#
use constant DOWNLOAD_MAP => {
  archs => {
    i386    => '32 bit',
    x86_64  => '64 bit',
  },
  desktops => {
    cinnamon  => 'Cinnamon',
    gnome     => 'GNOME',
    kde       => 'KDE',
    mate      => 'MATE',
    xfce      => 'Xfce',
  },
  releases => [
    {
      name      => 'Korora 22',
      version   => '22',
      codename  => 'Selina',
      isStable  => 1,
      isCurrent => 1,
      released  => '2 August 2015',
      available => 1,
      isos => {
        cinnamon => {
          i386 => {
            url => {
              http    => 'http://sourceforge.net/projects/kororaproject/files/22/korora-22-i386-cinnamon-live.iso/download',
              torrent => '/download/torrents/korora-22-i386-cinnamon-live-iso.torrent'
            },
            checksum => {
              md5     => '488cc2b1a01f6553b392425440cc6644',
              sha1    => '7a2be34ae8d47069ff4735331d8c2adc62a5bb6b',
              sha256  => 'd6145ae6130e0fd7b3320555c543c56954f857c469979a5b14321bf20196b685',
            },
          },
          x86_64 => {
            url => {
              http    => 'http://sourceforge.net/projects/kororaproject/files/22/korora-22-x86_64-cinnamon-live.iso/download',
              torrent => '/download/torrents/korora-22-x86_64-cinnamon-live-iso.torrent'
            },
            checksum => {
              md5     => 'ef71549bb6e88ea51cfa8f9424ad329f',
              sha1    => 'bc5ac60cfb1d769673c9622b226cd9f6b6ed636f',
              sha256  => '2a06f6486172ab060ea44479ab7852ca80329f1cca62144af9a37c8caa686b13'
            },
          },
        },
        gnome => {
          i386 => {
            url => {
              http    => 'http://sourceforge.net/projects/kororaproject/files/22/korora-22-i386-gnome-live.iso/download',
              torrent => '/download/torrents/korora-22-i386-gnome-live-iso.torrent'
            },
            checksum => {
              md5     => '3bbbbf2c60d22477613b51c3199570ce',
              sha1    => 'd0d3588aeee249f151c94c927b5ba29946c85bfd',
              sha256  => '7bf89d4c41d0052d5e29c05cde834d9ba9ee0db2ca3636e2dda5288dd5ce583b',
            },
          },
          x86_64 => {
            url => {
              http    => 'http://sourceforge.net/projects/kororaproject/files/22/korora-22-x86_64-gnome-live.iso/download',
              torrent => '/download/torrents/korora-22-x86_64-gnome-live-iso.torrent'
            },
            checksum => {
              md5     => 'fd51893712a42e1282a6644a8cf978a6',
              sha1    => 'e3425458c02790d4cc564277a9a34d5b1427d249',
              sha256  => '9ecef349b473257a13de2392a4a7edca11f88f7fa0dc6e9e900f5f1ec1258881'
            },
          },
        },
        kde => {
          i386 => {
            url => {
              http    => 'http://sourceforge.net/projects/kororaproject/files/22/korora-22-i386-kde-live.iso/download',
              torrent => '/download/torrents/korora-22-i386-kde-live-iso.torrent'
            },
            checksum => {
              md5     => 'afcb7743ed0bc05d2b0ee530ac49992b',
              sha1    => '1eeba35c2636cdeb17d6c2bbcadc63318bcc66d5',
              sha256  => 'b4f69e9762c3dc4b14f4d65d13e5bb8b2e827340d51c1b6c02a51e0d816e7706',
            },
          },
          x86_64 => {
            url => {
              http    => 'http://sourceforge.net/projects/kororaproject/files/22/korora-22-x86_64-kde-live.iso/download',
              torrent => '/download/torrents/korora-22-x86_64-kde-live-iso.torrent'
            },
            checksum => {
              md5     => '072ee9344d6935a0a00308d1e2901877',
              sha1    => 'c78184f0893aca8c64df29a3a9152735c5d745c2',
              sha256  => '124c60047d1c085a694f8c91afc595cc6b41496a649d9bc5f668c69684806fe7'
            },
          },
        },
        mate => {
          i386 => {
            url => {
              http    => 'http://sourceforge.net/projects/kororaproject/files/22/korora-22-i386-mate-live.iso/download',
              torrent => '/download/torrents/korora-22-i386-mate-live-iso.torrent'
            },
            checksum => {
              md5     => 'fc9cecc80517f8d100ea03ddce0fe706',
              sha1    => '96e45533a2601bded6b5e8226ae410e90323920d',
              sha256  => '7db79f6f0daf6e5a58067390f2cebdc135299892107d1d367df58c9d4ead9930',
            },
          },
          x86_64 => {
            url => {
              http    => 'http://sourceforge.net/projects/kororaproject/files/22/korora-22-x86_64-mate-live.iso/download',
              torrent => '/download/torrents/korora-22-x86_64-mate-live-iso.torrent'
            },
            checksum => {
              md5     => '1d753a4c8d8c7779edc0476e71e6a6bc',
              sha1    => '086be38a1c03590a1ab3fbe0f7ecaae5b2eeef98',
              sha256  => '43827ea0a85cc9c55ebb872287d2299edc52ae342a96116f1d88e2b6e095234e'
            },
          },
        },
        xfce => {
          i386 => {
            url => {
              http    => 'http://sourceforge.net/projects/kororaproject/files/22/korora-22-i386-xfce-live.iso/download',
              torrent => '/download/torrents/korora-22-i386-xfce-live-iso.torrent'
            },
            checksum => {
              md5     => '2acc91bed582e638180ffe1a91b8cc01',
              sha1    => '121602fc333834aac8659ca20763a37209997e6d',
              sha256  => '4af9980097539be0c1c757681f39086879678f02130e63c0b200f173b577e109'
            },
          },
          x86_64 => {
            url => {
              http    => 'http://sourceforge.net/projects/kororaproject/files/22/korora-22-x86_64-xfce-live.iso/download',
              torrent => '/download/torrents/korora-22-x86_64-xfce-live-iso.torrent'
            },
            checksum => {
              md5     => 'd32bd52cde884112b5f13a045d751f2d',
              sha1    => '7b48b362c929ca086d1540f0d8dcd427370a8290',
              sha256  => 'b1a8ecac5bb13192bb26ece85d0059427d410a1536fd6b77e92fc139f8b3a643',
            },
          },
        },
      },
    },
    {
      name      => 'Korora 21',
      version   => '21',
      codename  => 'Darla',
      isStable  => 1,
      isCurrent => 0,
      released  => '6 February 2015',
      available => 1,
      isos => {
        cinnamon => {
          i386 => {
            url => {
              http    => 'http://sourceforge.net/projects/kororaproject/files/21/korora-21-i386-cinnamon-live.iso/download',
              torrent => '/download/torrents/korora-21-i386-cinnamon-live-iso.torrent'
            },
            checksum => {
              md5     => 'de6252cd96cacc888b4acbef8c8afec2',
              sha1    => 'ce3f6b9bb84c4573a5b8a2ad9904da2e8ba8f435',
              sha256  => '6fe00371dfc12a7e12283e5f2c49d454947e514a6869676c12fe947279062ccd',
            },
          },
          x86_64 => {
            url => {
              http    => 'http://sourceforge.net/projects/kororaproject/files/21/korora-21-x86_64-cinnamon-live.iso/download',
              torrent => '/download/torrents/korora-21-x86_64-cinnamon-live-iso.torrent'
            },
            checksum => {
              md5    => 'd600dfbd777d4b39385dab7b1ad95783',
              sha1   => '0a8897c3a74666452733e9b5d550efa18637a8a3',
              sha256 => 'a44e7e2f3ad0fbe67a35aa3d71bf9f2e81eb1ba8a3f11075eba970996c3fe269'
            },
          },
        },
        gnome => {
          i386 => {
            url => {
              http    => 'http://sourceforge.net/projects/kororaproject/files/21/korora-21-i386-gnome-live.iso/download',
              torrent => '/download/torrents/korora-21-i386-gnome-live-iso.torrent'
            },
            checksum => {
              md5     => '59aa3addf189861b9d0cb1f3e3d1169b',
              sha1    => '5fcecabcb43028a4d2d341730f216d03fcdcb307',
              sha256  => 'fa38a6039ced9995cb8c0ccf6662cf3989d25fc659f2f4779b64298771766782',
            },
          },
          x86_64 => {
            url => {
              http    => 'http://sourceforge.net/projects/kororaproject/files/21/korora-21-x86_64-gnome-live.iso/download',
              torrent => '/download/torrents/korora-21-x86_64-gnome-live-iso.torrent'
            },
            checksum => {
              md5     => '741fbae6cc9246892a7ca8172b3674f1',
              sha1    => '2c8cdecdd0324f83ce4d5a0c5f16b71d99ff4e08',
              sha256  => 'b5794237aadb9a719b5dd35c4ef3d908d90b20debb8f6b2c94884ada74628bcf'
            },
          },
        },
        kde => {
          i386 => {
            url => {
              http    => 'http://sourceforge.net/projects/kororaproject/files/21/korora-21-i386-kde-live.iso/download',
              torrent => '/download/torrents/korora-21-i386-kde-live-iso.torrent'
            },
            checksum => {
              md5     => '76c8041a8b447f948c931050e101f0ba',
              sha1    => 'b259d451e120424aa545ab04f3ea73911f2c5e11',
              sha256  => '2a7722dc56d481f8825851fab28014cede6cb250df7a5f7788420011a4c98185',
            },
          },
          x86_64 => {
            url => {
              http    => 'http://sourceforge.net/projects/kororaproject/files/21/korora-21-x86_64-kde-live.iso/download',
              torrent => '/download/torrents/korora-21-x86_64-kde-live-iso.torrent'
            },
            checksum => {
              md5     => '8a75040a6f426292319aff5375ddbddc',
              sha1    => '9a72b79d00c9c8815203a1665b7af066cafc2b10',
              sha256  => '76578bc4ae127a58f3bab490fde957e6d944661d4f292e75f8b6d274721fd447'
            },
          },
        },
        mate => {
          i386 => {
            url => {
              http    => 'http://sourceforge.net/projects/kororaproject/files/21/korora-21-i386-mate-live.iso/download',
              torrent => '/download/torrents/korora-21-i386-mate-live-iso.torrent'
            },
            checksum => {
              md5     => 'e40d088cd651e1cabe8e9c7d00aa54cd',
              sha1    => '66a5febbfcc9dd8b9be946cac628f4ab9b733360',
              sha256  => 'c1055da14129ef6bfd4f2a52831adefc24a540b5b31e90b294f1bcbbfbb7fe52',
            },
          },
          x86_64 => {
            url => {
              http    => 'http://sourceforge.net/projects/kororaproject/files/21/korora-21-x86_64-mate-live.iso/download',
              torrent => '/download/torrents/korora-21-x86_64-mate-live-iso.torrent'
            },
            checksum => {
              md5     => '14f99f028066071309b242da6686bb7a',
              sha1    => '401768ee437c5e0472944763e1b22999de751d0b',
              sha256  => 'fdfb88bc86de4b8eec5e92b6d1ca49ba473d30438184d93be4c14ec726585644'
            },
          },
        },
        xfce => {
          i386 => {
            url => {
              http    => 'http://sourceforge.net/projects/kororaproject/files/21/korora-21-i386-xfce-live.iso/download',
              torrent => '/download/torrents/korora-21-i386-xfce-live-iso.torrent'
            },
            checksum => {
              md5     => '8a355a3c797d767e57720b080f2592f8',
              sha1    => 'b447a279fc67dca235d2e4db326fcfae862320d0',
              sha256  => 'c62212897f7f0aa6027d56ffdb34d4b4ca6f62b3d4cb85c308755ff11bc0875c'
            },
          },
          x86_64 => {
            url => {
              http    => 'http://sourceforge.net/projects/kororaproject/files/21/korora-21-x86_64-xfce-live.iso/download',
              torrent => '/download/torrents/korora-21-x86_64-xfce-live-iso.torrent'
            },
            checksum => {
              md5     => '08f8e173e89735bba69fde8f81b7ebb6',
              sha1    => 'a7a803e7ad155876ad5a0ea5b8bd776c9a66b22b',
              sha256  => '492ad02a512f995d0f1cb43e30eca78bc79642ff56e25960c1c6c9f4395552e7',
            },
          },
        },
      },
    },
  ]
};

#
# CONTROLLER HANDLERS
#
sub index {
  my $c = shift;

  $c->stash(map => DOWNLOAD_MAP, static_map => encode_json(DOWNLOAD_MAP));

  $c->render('website/download');
}

sub torrent_file {
  my $c = shift;
  my $file = $c->param('file');

  $c->res->headers->content_type('application/x-bittorrent');
  $c->reply->static('torrents/' . $file);
}

1;
