#!perl
#
#
use 5.001;
use strict;
use warnings;
use warnings::register;

use vars qw($VERSION $DATE);
$VERSION = '0.01';   # automatically generated file
$DATE = '2003/07/04';


##### Demonstration Script ####
#
# Name: PM2File.d
#
# UUT: File::PM2File
#
# The module Test::STDmaker generated this demo script from the contents of
#
# t::File::PM2File 
#
# Don't edit this test script file, edit instead
#
# t::File::PM2File
#
#	ANY CHANGES MADE HERE TO THIS SCRIPT FILE WILL BE LOST
#
#       the next time Test::STDmaker generates this script file.
#
#

######
#
# The working directory is the directory of the generated file
#
use vars qw($__restore_dir__ @__restore_inc__ );

BEGIN {
    use Cwd;
    use File::Spec;
    use File::TestPath;
    use Test::Tech qw(tech_config plan demo);

    ########
    # Working directory is that of the script file
    #
    $__restore_dir__ = cwd();
    my ($vol, $dirs, undef) = File::Spec->splitpath(__FILE__);
    chdir $vol if $vol;
    chdir $dirs if $dirs;

    #######
    # Add the library of the unit under test (UUT) to @INC
    #
    @__restore_inc__ = File::TestPath->test_lib2inc();

    unshift @INC, File::Spec->catdir( cwd(), 'lib' ); 

}

END {

   #########
   # Restore working directory and @INC back to when enter script
   #
   @INC = @__restore_inc__;
   chdir $__restore_dir__;

}

print << 'MSG';

 ~~~~~~ Demonstration overview ~~~~~
 
Perl code begins with the prompt

 =>

The selected results from executing the Perl Code 
follow on the next lines. For example,

 => 2 + 2
 4

 ~~~~~~ The demonstration follows ~~~~~

MSG

demo( "\ \ \ \ use\ File\:\:Spec\;\
\
\ \ \ \ use\ File\:\:Package\;\
\ \ \ \ my\ \$fp\ \=\ \'File\:\:Package\'\;\
\
\ \ \ \ my\ \$pm\ \=\ \'File\:\:PM2File\'\;\
\ \ \ \ my\ \$loaded\ \=\ \'\'\;"); # typed in command           
          use File::Spec;

    use File::Package;
    my $fp = 'File::Package';

    my $pm = 'File::PM2File';
    my $loaded = '';; # execution

demo( "my\ \$errors\ \=\ \$fp\-\>load_package\(\ \'File\:\:PM2File\'\ \)"); # typed in command           
      my $errors = $fp->load_package( 'File::PM2File' ); # execution

demo( "\$errors", # typed in command           
      $errors # execution
) unless     $loaded; # condition for execution                            

demo( "\$pm\-\>pm2require\(\ \"\$pm\"\)", # typed in command           
      $pm->pm2require( "$pm")); # execution


demo( "\ \ \ \ \#\#\#\#\#\#\#\
\ \ \ \ \#\ Use\ the\ test\ file\ as\ an\ example\ since\ no\ its\ absolue\ path\
\ \ \ \ \#\
\ \ \ \ \#\ Calculate\ the\ absolute\ file\,\ relative\ file\,\ and\ include\ directory\
\ \ \ \ \#\ \ \ \ \
\ \ \ \ my\ \$relative_file\ \=\ File\:\:Spec\-\>catfile\(\'t\'\,\ \'File\'\,\ \'PM2File\.pm\'\)\;\ \
\
\ \ \ \ my\ \$restore_dir\ \=\ cwd\(\)\;\
\ \ \ \ chdir\ File\:\:Spec\-\>updir\(\)\;\
\ \ \ \ chdir\ File\:\:Spec\-\>updir\(\)\;\
\ \ \ \ my\ \$include_dir\ \=\ cwd\(\)\;\
\ \ \ \ chdir\ \$restore_dir\;\
\ \ \ \ \$include_dir\ \=\~\ s\=\/\=\\\\\=g\;\
\
\ \ \ \ my\ \$absolute_file\ \=\ File\:\:Spec\-\>catfile\(\$include_dir\,\ \'t\'\,\ \'File\'\,\ \'PM2File\.pm\'\)\;\
\ \ \ \ \$absolute_file\ \=\~\ s\=\.t\$\=\.pm\=\;\
\
\
\ \ \ \ \#\#\#\#\#\#\
\ \ \ \ \#\ Put\ base\ directory\ as\ the\ first\ in\ the\ \@INC\ path\
\ \ \ \ \#\
\ \ \ \ my\ \@restore_inc\ \=\ \@INC\;\
\ \ \ \ unshift\ \@INC\,\ \$include_dir\;\ \ \ \ \
\
\ \ \ \ \#\#\#\#\#\#\
\ \ \ \ \#\ Use\ the\ method\ under\ Test\ to\ find\ the\ absolute\ file\ and\ include\ directory\
\ \ \ \ \#\
\ \ \ \ my\ \@actual\ \=\ \ \$pm\-\>find_in_include\(\ \$relative_file\ \)\;\
\
\ \ \ \ \@INC\ \=\ \@restore_inc\;"); # typed in command           
          #######
    # Use the test file as an example since no its absolue path
    #
    # Calculate the absolute file, relative file, and include directory
    #    
    my $relative_file = File::Spec->catfile('t', 'File', 'PM2File.pm'); 

    my $restore_dir = cwd();
    chdir File::Spec->updir();
    chdir File::Spec->updir();
    my $include_dir = cwd();
    chdir $restore_dir;
    $include_dir =~ s=/=\\=g;

    my $absolute_file = File::Spec->catfile($include_dir, 't', 'File', 'PM2File.pm');
    $absolute_file =~ s=.t$=.pm=;


    ######
    # Put base directory as the first in the @INC path
    #
    my @restore_inc = @INC;
    unshift @INC, $include_dir;    

    ######
    # Use the method under Test to find the absolute file and include directory
    #
    my @actual =  $pm->find_in_include( $relative_file );

    @INC = @restore_inc;; # execution

demo( "\[\@actual\]", # typed in command           
      [@actual]); # execution


demo( "\@actual\ \=\ \$pm\-\>pm2file\(\ \'t\:\:File\:\:PM2File\'\ \)"); # typed in command           
      @actual = $pm->pm2file( 't::File::PM2File' ); # execution

demo( "\[\@actual\]", # typed in command           
      [@actual]); # execution



=head1 NAME

PM2File.d - demostration script for File::PM2File

=head1 SYNOPSIS

 PM2File.d

=head1 OPTIONS

None.

=head1 COPYRIGHT

copyright © 2003 Software Diamonds.

Software Diamonds permits the redistribution
and use in source and binary forms, with or
without modification, provided that the 
following conditions are met: 

=over 4

=item 1

Redistributions of source code, modified or unmodified
must retain the above copyright notice, this list of
conditions and the following disclaimer. 

=item 2

Redistributions in binary form must 
reproduce the above copyright notice,
this list of conditions and the following 
disclaimer in the documentation and/or
other materials provided with the
distribution.

=back

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

## end of test script file ##

=cut

