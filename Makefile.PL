use ExtUtils::MakeMaker;
# $Id: Makefile.PL,v 1.1.1.1 2006/08/26 14:23:17 tinita Exp $
# $Id: Makefile.PL,v 1.1.1.1 2006/08/26 14:23:17 tinita Exp $
WriteMakefile(
    NAME              => 'HTML::Template::Compiled::Plugin::InlineImage',
    VERSION_FROM      => 'lib/HTML/Template/Compiled/Plugin/InlineImage.pm',
    PREREQ_PM         => {
        'HTML::Template::Compiled' => '0.73',
        'GD' => 0,
        'MIME::Base64' => 0,
    },
    ($] >= 5.005 ?     ## Add these new keywords supported since 5.005
      (ABSTRACT_FROM  => 'lib/HTML/Template/Compiled/Plugin/InlineImage.pm',
       AUTHOR         => 'tina <cpan2 (at) tinita.de>') : ()),
);
