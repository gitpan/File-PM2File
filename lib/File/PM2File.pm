#!perl
#
# Documentation, copyright and license is at the end of this file.
#


package  File::PM2File;

use 5.001;
use strict;
use warnings;
use warnings::register;

use vars qw($VERSION $DATE $FILE);
$VERSION = '1.1';
$DATE = '2003/07/11';
$FILE = __FILE__;

use File::Spec;

######
#
#
sub pm2file
{
   my (undef, $pm) = @_;
   my $require = File::PM2File->pm2require( $pm );
   my ($abs_file,$inc_path) = File::PM2File->find_in_include($require);
   ($abs_file,$inc_path, $require)
}


####
# Find find
#
sub find_in_include
{
   my (undef, $file, $path) = @_;

   $path = \@INC unless( $path );

   ######
   # Find the file in the search path
   #
   (undef, my $dirs, $file) = File::Spec->splitpath( $file ); 
   my (@dirs) = File::Spec->splitdir( $dirs );
   foreach my $path_dir (@$path) {
       my $abs_file = File::Spec->catfile( $path_dir, @dirs, $file );  
       if(-f $abs_file) {
          $path_dir =~ s|/|\\|g if $^O eq 'MSWin32'; # MicroSoft thing
          return ($abs_file, $path_dir) ;
       }
   }
   return undef;
}


#####
#
#
sub pm2require
{
   my (undef, $pm) = @_;
   $pm .= '.pm';
   my @dirs = split /::/, $pm;
   my $require = File::Spec->catfile( @dirs );

}

1

__END__

=head1 NAME

File::PM2File - find the absolute file for an unloaded program module

=head1 SYNOPSIS

  use File::PM2File

  ($abs_file, $inc_path, $require) = File::PM2File->pm2file($pm)
  ($abs_file, $inc_path)           = File::PM2File->find_in_include($file, [\@path])
  $file                            = File::PM2File->pm2require($pm)

=head DESCRIPTION

From time to time, an program needs to know the abolute file for a program
module that has not been loaded. The File::PM2File module provides methods
to find this information.

=head1 METHODS

=head2 find_in_include method

 ($abs_file, $inc_path) = File::PM2File->find_in_path($fspec, $file_relative, [\@path])

The I<find_in_path> method looks for the I<$file_relative> in one of the directories in
the the I<@path> (I<@INC> path if I<@path> not supplied) in the order listed.
The file I<$file_relative> may include relative directories.
When I<find_in_include> finds the file, it returns the absolute file I<$file_absolute> and
the directory I<$path> where it found I<$file_relative>.

=head2 pm2file method

  ($abs_file, $inc_path) = File::PM2File->pm2file($pm_file)

The I<pm2file> method returns the absolute file and
the directory in I<@INC> for a the program module
I<$pm_file>.

=head2 pm2require

 $file = File::PM2File->pm2require($pm_file)

The I<pm2require> method returns the file suitable
for use in a Perl I<require> given the I<$pm_file>
file.

=head1 REQUIREMENTS

Coming soon.

=head1 DEMONSTRATION

 ~~~~~~ Demonstration overview ~~~~~

Perl code begins with the prompt

 =>

The selected results from executing the Perl Code 
follow on the next lines. For example,

 => 2 + 2
 4

 ~~~~~~ The demonstration follows ~~~~~

 =>     use File::Spec;

 =>     use File::Package;
 =>     my $fp = 'File::Package';

 =>     my $pm = 'File::PM2File';
 =>     my $loaded = '';
 => my $errors = $fp->load_package( 'File::PM2File' )
 => $errors
 ''

 => $pm->pm2require( "$pm")
 'File\PM2File.pm'

 =>     #######
 =>     # Use the test file as an example since no its absolue path
 =>     #
 =>     # Calculate the absolute file, relative file, and include directory
 =>     #    
 =>     my $relative_file = File::Spec->catfile('t', 'File', 'PM2File.pm'); 

 =>     my $restore_dir = cwd();
 =>     chdir File::Spec->updir();
 =>     chdir File::Spec->updir();
 =>     my $include_dir = cwd();
 =>     chdir $restore_dir;
 =>     $include_dir =~ s=/=\\=g;

 =>     my $absolute_file = File::Spec->catfile($include_dir, 't', 'File', 'PM2File.pm');
 =>     $absolute_file =~ s=.t$=.pm=;

 =>     ######
 =>     # Put base directory as the first in the @INC path
 =>     #
 =>     my @restore_inc = @INC;
 =>     unshift @INC, $include_dir;    

 =>     ######
 =>     # Use the method under Test to find the absolute file and include directory
 =>     #
 =>     my @actual =  $pm->find_in_include( $relative_file );

 =>     @INC = @restore_inc;
 => [@actual]
 [
           'E:\User\SoftwareDiamonds\installation\t\File\PM2File.pm',
           'E:\User\SoftwareDiamonds\installation'
         ]

 => @actual = $pm->pm2file( 't::File::PM2File' )
 => [@actual]
 [
           'E:\User\SoftwareDiamonds\installation\t\File\PM2File.pm',
           'E:\User\SoftwareDiamonds\installation',
           't\File\PM2File.pm'
         ]


=head1 QUALITY ASSURANCE

The module "t::File::PM2File" is the Software
Test Description(STD) module for the "File::PM2File".
module. 

To generate all the test output files, 
run the generated test script,
run the demonstration script and include it results in the "File::PM2File" POD,
execute the following in any directory:

 tmake -test_verbose -replace -run  -pm=t::File::PM2File

Note that F<tmake.pl> must be in the execution path C<$ENV{PATH}>
and the "t" directory containing  "t::File::PM2File" on the same level as the "lib" 
directory that contains the "File::PM2File" module.

=head1 NOTES

=head2 AUTHOR

The holder of the copyright and maintainer is

E<lt>support@SoftwareDiamonds.comE<gt>

=head2 COPYRIGHT NOTICE

Copyrighted (c) 2002 Software Diamonds

All Rights Reserved

=head2 BINDING REQUIREMENTS NOTICE

Binding requirements are indexed with the
pharse 'shall[dd]' where dd is an unique number
for each header section.
This conforms to standard federal
government practices, 490A (L<STD490A/3.2.3.6>).
In accordance with the License, Software Diamonds
is not liable for any requirement, binding or otherwise.

=head2 LICENSE

Software Diamonds permits the redistribution
and use in source and binary forms, with or
without modification, provided that the 
following conditions are met: 

=over 4

=item 1

Redistributions of source code must retain
the above copyright notice, this list of
conditions and the following disclaimer. 

=item 2

Redistributions in binary form must 
reproduce the above copyright notice,
this list of conditions and the following 
disclaimer in the documentation and/or
other materials provided with the
distribution.

=back

SOFTWARE DIAMONDS, http::www.softwarediamonds.com,
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


=for html
<p><br>
<!-- BLK ID="NOTICE" -->
<!-- /BLK -->
<p><br>
<!-- BLK ID="OPT-IN" -->
<!-- /BLK -->
<p><br>
<!-- BLK ID="EMAIL" -->
<!-- /BLK -->
<p><br>
<!-- BLK ID="COPYRIGHT" -->
<!-- /BLK -->
<p><br>
<!-- BLK ID="LOG_CGI" -->
<!-- /BLK -->
<p><br>

=cut

### end of file ###