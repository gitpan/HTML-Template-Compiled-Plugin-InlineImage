use strict;
use warnings;
use Module::Build;

my $build = Module::Build->new(
    create_makefile_pl => 'traditional',
    license            => 'perl',
    module_name        => 'HTML::Template::Compiled::Plugin::InlineImage',
    requires           => {
        'HTML::Template::Compiled' => '0.73',
        'GD' => 0,
        'MIME::Base64' => 0,
    },
    reccomends         => {},
    create_readme      => 1,
    sign               => 0,
);
$build->create_build_script;
