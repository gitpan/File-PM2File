#!perl
#
#
use 5.001;
use strict;
use warnings;
use warnings::register;

use vars qw($VERSION $DATE $FILE);
$VERSION = '0.12';   # automatically generated file
$DATE = '2004/04/09';
$FILE = __FILE__;


##### Test Script ####
#
# Name: PM2File.t
#
# UUT: File::PM2File
#
# The module Test::STDmaker generated this test script from the contents of
#
# t::File::PM2File;
#
# Don't edit this test script file, edit instead
#
# t::File::PM2File;
#
#	ANY CHANGES MADE HERE TO THIS SCRIPT FILE WILL BE LOST
#
#       the next time Test::STDmaker generates this script file.
#
#

######
#
# T:
#
# use a BEGIN block so we print our plan before Module Under Test is loaded
#
BEGIN { 

   use FindBin;
   use File::Spec;
   use Cwd;

   ########
   # The working directory for this script file is the directory where
   # the test script resides. Thus, any relative files written or read
   # by this test script are located relative to this test script.
   #
   use vars qw( $__restore_dir__ );
   $__restore_dir__ = cwd();
   my ($vol, $dirs) = File::Spec->splitpath($FindBin::Bin,'nofile');
   chdir $vol if $vol;
   chdir $dirs if $dirs;

   #######
   # Pick up any testing program modules off this test script.
   #
   # When testing on a target site before installation, place any test
   # program modules that should not be installed in the same directory
   # as this test script. Likewise, when testing on a host with a @INC
   # restricted to just raw Perl distribution, place any test program
   # modules in the same directory as this test script.
   #
   use lib $FindBin::Bin;

   ########
   # Using Test::Tech, a very light layer over the module "Test" to
   # conduct the tests.  The big feature of the "Test::Tech: module
   # is that it takes expected and actual references and stringify
   # them by using "Data::Secs2" before passing them to the "&Test::ok"
   # Thus, almost any time of Perl data structures may be
   # compared by passing a reference to them to Test::Tech::ok
   #
   # Create the test plan by supplying the number of tests
   # and the todo tests
   #
   require Test::Tech;
   Test::Tech->import( qw(plan ok skip skip_tests tech_config finish) );
   plan(tests => 5);

}


END {
 
   #########
   # Restore working directory and @INC back to when enter script
   #
   @INC = @lib::ORIG_INC;
   chdir $__restore_dir__;
}

   # Perl code from C:
    use File::Spec;
    use File::Package;
    my $fp = 'File::Package';
    my $uut = 'File::PM2File';
    my $loaded = '';

    # Use the test file as an example since no its absolue path
    # Calculate the absolute file, relative file, and include directory
    my $relative_file = File::Spec->catfile('t', 'File', 'PM2File.pm'); 

    my $restore_dir = cwd();
    chdir File::Spec->updir();
    chdir File::Spec->updir();
    my $include_dir = cwd();
    chdir $restore_dir;
    my $OS = $^O;  # need to escape ^
    unless ($OS) {   # on some perls $^O is not defined
        require Config;
        $OS = $Config::Config{'osname'};
    } 
    $include_dir =~ s=/=\\=g if( $^O eq 'MSWin32');
    my $absolute_file = File::Spec->catfile($include_dir, 't', 'File', 'PM2File.pm');
    $absolute_file =~ s=.t$=.pm=;

    # Put base directory as the first in the @INC path
    my @restore_inc = @INC;
    unshift @INC, $include_dir;

ok(  $loaded = $fp->is_package_loaded('File::PM2File'), # actual results
      '', # expected results
     "",
     "UUT not loaded");

#  ok:  1

skip_tests( 1 ) unless skip(
      $loaded, # condition to skip test   
      my $errors = $fp->load_package( 'File::PM2File' ), # actual results
      '',  # expected results
      "",
      "Load UUT");
 
#  ok:  2

ok(  $uut->pm2require( "$uut"), # actual results
     File::Spec->catfile('File', 'PM2File' . '.pm'), # expected results
     "",
     "pm2require");

#  ok:  3

ok(  [my @actual =  $uut->find_in_include( $relative_file )], # actual results
     [$absolute_file, $include_dir], # expected results
     "",
     "find_in_include");

#  ok:  4

ok(  [@actual = $uut->pm2file( 't::File::PM2File' )], # actual results
     [$absolute_file, $include_dir, $relative_file], # expected results
     "",
     "pm2file");

#  ok:  5

   # Perl code from C:
@INC = @restore_inc;


    finish();

__END__

=head1 NAME

PM2File.t - test script for File::PM2File

=head1 SYNOPSIS

 PM2File.t -log=I<string>

=head1 OPTIONS

All options may be abbreviated with enough leading characters
to distinguish it from the other options.

=over 4

=item C<-log>

PM2File.t uses this option to redirect the test results 
from the standard output to a log file.

=back

=head1 COPYRIGHT

copyright � 2003 Software Diamonds.

Software Diamonds permits the redistribution
and use in source and binary forms, with or
without modification, provided that the 
following conditions are met: 

/=over 4

/=item 1

Redistributions of source code, modified or unmodified
must retain the above copyright notice, this list of
conditions and the following disclaimer. 

/=item 2

Redistributions in binary form must 
reproduce the above copyright notice,
this list of conditions and the following 
disclaimer in the documentation and/or
other materials provided with the
distribution.

/=back

SOFTWARE DIAMONDS, http://www.SoftwareDiamonds.com,
PROVIDES THIS SOFTWARE 
'AS IS' AND ANY EXPRESS OR IMPLIED WARRANTIES,
INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT
SHALL SOFTWARE DIAMONDS BE LIABLE FOR ANY DIRECT,
INDIRECT, INCIDENTAL, SPECIAL,EXEMPLARY, OR 
CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED
TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
LOSS OF USE,DATA, OR PROFITS; OR BUSINESS
INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY
OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY,
OR TORT (INCLUDING USE OF THIS SOFTWARE, EVEN IF
ADVISED OF NEGLIGENCE OR OTHERWISE) ARISING IN
ANY WAY OUT OF THE POSSIBILITY OF SUCH DAMAGE.

=cut

## end of test script file ##

