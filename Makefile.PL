use strict;
use warnings;

BEGIN {
    my @devmods = qw(
        Module::Install::AuthorTests
        Module::Install::ReadmeFromPod
        Module::Install::Repository
    );
    my @not_available;

    {
        $|=1;
        local *STDOUT;
        eval qq{use inc::Module::Install; 1;} or push @not_available, 'inc::Module::Install';
    }

    for my $mod (@devmods) {
        eval qq{require $mod} or push @not_available, $mod;
    }
    if (@not_available) {
        print qq{# The following modules are not available.\n};
        print qq{# `$^X $0 | cpanm` will install them:\n};
        print $_, "\n" for @not_available;
        print "\n";
        exit -1;
    }
}

use inc::Module::Install;
$Module::Install::AUTHOR = 0 if $ENV{TRAVIS};

name 'GitDDL';
all_from 'lib/GitDDL.pm';
readme_from 'lib/GitDDL.pm';

test_requires 'Test::More' => '0.86';
test_requires 'Test::Git';

requires 'perl' => '5.008001';
requires 'SQL::Translator' => '0.11016';
requires 'DBI';
requires 'Git::Repository';
requires 'File::Path' =>'2.07';

author_tests 'xt';
auto_set_repository;

WriteAll;
