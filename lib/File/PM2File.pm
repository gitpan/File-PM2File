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
$VERSION = '1.12';
$DATE = '2003/09/20';
$FILE = __FILE__;

use vars qw(@ISA @EXPORT_OK);
use Exporter;
@ISA = qw(Exporter);
@EXPORT_OK = qw(pm2file find_in_include pm2require);

use File::Spec;
use SelfLoader;

1

__DATA__

######
#
#
sub pm2file
{
     shift @_ if UNIVERSAL::isa($_[0],__PACKAGE__);
     my $require = pm2require( $_[0] );
     my ($abs_file,$inc_path) = find_in_include($require);
     return ($abs_file,  $inc_path, $require) if wantarray;
     $abs_file;
}


####
# Find find
#
sub find_in_include
{

     shift @_ if UNIVERSAL::isa($_[0],__PACKAGE__);
     my ($file, $path) = @_;

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
             return ($abs_file, $path_dir) if wantarray;
             return $abs_file;
         }
     }
     undef;
}


#####
#
#
sub pm2require
{

     shift @_ if UNIVERSAL::isa($_[0],__PACKAGE__);
     File::Spec->catfile( split /::/, $_[0] . '.pm');

}
 
1

__END__

=head1 NAME

File::PM2File - find the absolute file for a program module, loaded or unloaded

=head1 SYNOPSIS

  #######
  # Direct class interface
  #
  ($abs_file, $inc_path, $require) = File::PM2File->pm2file($pm);
  $abs_file                        = File::PM2File->pm2file($pm);

  ($abs_file, $inc_path)           = File::PM2File->find_in_include($file_relative, [\@path]);
  $abs_file                        = File::PM2File->find_in_include($file_relative, [\@path]);

  $file                            = File::PM2File->pm2require($pm);

  #########
  # class interface where the PM2FILE methods are inherited by another class
  #
  use vars (@ISA);    
  use File::PM2File;   
  @ISA = qw(File::PM2File);
 
  ($abs_file, $inc_path, $require) = __PACKAGE__->pm2file($pm);
  $abs_file                        = __PACKAGE__->pm2file($pm);

  ($abs_file, $inc_path)           = __PACKAGE__->find_in_include($file_relative, [\@path]);
  $abs_file                        = __PACKAGE__->find_in_include($file_relative, [\@path]);

  $file                            = __PACKAGE__->pm2require($pm);


  #######
  # Subroutine interface
  #  
  use File::PM2File qw(pm2file find_in_include pm2require);  

  ($abs_file, $inc_path, $require) = pm2file($pm);
  $abs_file                        = pm2file($pm);

  ($abs_file, $inc_path)           = find_in_include($file_relative, [\@path]);
  $abs_file                        = find_in_include($file_relative, [\@path]);

  $file                            = pm2require($pm);

=head DESCRIPTION

From time to time, an program needs to know the abolute file for a program
module that has not been loaded. The File::PM2File module provides methods
to find this information. For loaded files, using the hash %INC may
perform better than using the methods in this module.

=head1 METHODS/SUBROUTINES

=head2 find_in_include method/subroutine

 ($abs_file, $inc_path) = File::PM2File->find_in_include($file_relative, [\@path])

 ($abs_file, $inc_path) = find_in_include($file_relative, [\@path])

The I<find_in_include> method/subroutine looks for the I<$file_relative> in one of the directories in
the the I<@path> (I<@INC> path if I<@path> not supplied) in the order listed.
The file I<$file_relative> may include relative directories.
When I<find_in_include> finds the file, it returns the absolute file I<$file_absolute> and
the directory I<$path> where it found I<$file_relative>.

=head2 pm2file method/subroutine

  ($abs_file, $inc_path, $require_file) = File::PM2File->pm2file($pm)

  ($abs_file, $inc_path, $require_file) = pm2file($pm)

The I<pm2file> method returns the absolute file, 
the directory in I<@INC>, and the relative I<$require_file>
for a the program module I<$pm_file>.

=head2 pm2require method/subroutine

 $file = File::PM2File->pm2require($pm_file)

 $file = pm2require($pm_file)


The I<pm2require> method/subroutine returns the file suitable
for use in a Perl I<require> given the I<$pm>
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
 =>     if( $^O eq 'MSWin32') {
 =>         $include_dir =~ s=/=\\=g;
 =>     }

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

Running the test script 'PM2File.t' found in
the "File-PM2File-$VERSION.tar.gz" distribution file verifies
the requirements for this module.

All testing software and documentation
stems from the 
Software Test Description (L<STD|Docs::US_DOD::STD>)
program module 't::File::PM2File',
found in the distribution file 
"File-PM2File-$VERSION.tar.gz". 

The 't::File::PM2File' L<STD|Docs::US_DOD::STD> POD contains
a tracebility matix between the
requirements established above for this module, and
the test steps identified by a
'ok' number from running the 'PM2File.t'
test script.

The t::File::PM2File' L<STD|Docs::US_DOD::STD>
program module '__DATA__' section contains the data 
to perform the following:

=over 4

=item *

to generate the test script 'PM2File.t'

=item *

generate the tailored 
L<STD|Docs::US_DOD::STD> POD in
the 't::File::PM2File' module, 

=item *

generate the 'PM2File.d' demo script, 

=item *

replace the POD demonstration section
herein with the demo script
'PM2File.d' output, and

=item *

run the test script using Test::Harness
with or without the verbose option,

=back

To perform all the above, prepare
and run the automation software as 
follows:

=over 4

=item *

Install "Test_STDmaker-$VERSION.tar.gz"
from one of the respositories only
if it has not been installed:

=over 4

=item *

http://www.softwarediamonds/packages/

=item *

http://www.perl.com/CPAN-local/authors/id/S/SO/SOFTDIA/

=back
  
=item *

manually place the script tmake.pl
in "Test_STDmaker-$VERSION.tar.gz' in
the site operating system executable 
path only if it is not in the 
executable path

=item *

place the 't::File::PM2File' at the same
level in the directory struture as the
directory holding the 'File::PM2File'
module

=item *

execute the following in any directory:

 tmake -test_verbose -replace -run -pm=t::File::PM2File

=back

=head1 NOTES

=head2 FILES

The installation of the
"File-PM2File-$VERSION.tar.gz" distribution file
installs the 'Docs::Site_SVD::File_PM2File'
L<SVD|Docs::US_DOD::SVD> program module.

The __DATA__ data section of the 
'Docs::Site_SVD::File_PM2File' contains all
the necessary data to generate the POD
section of 'Docs::Site_SVD::File_PM2File' and
the "File-PM2File-$VERSION.tar.gz" distribution file.

To make use of the 
'Docs::Site_SVD::File_PM2File'
L<SVD|Docs::US_DOD::SVD> program module,
perform the following:

=over 4

=item *

install "ExtUtils-SVDmaker-$VERSION.tar.gz"
from one of the respositories only
if it has not been installed:

=over 4

=item *

http://www.softwarediamonds/packages/

=item *

http://www.perl.com/CPAN-local/authors/id/S/SO/SOFTDIA/

=back

=item *

manually place the script vmake.pl
in "ExtUtils-SVDmaker-$VERSION.tar.gz' in
the site operating system executable 
path only if it is not in the 
executable path

=item *

Make any appropriate changes to the
__DATA__ section of the 'Docs::Site_SVD::File_PM2File'
module.
For example, any changes to
'File::PM2File' will impact the
at least 'Changes' field.

=item *

Execute the following:

 vmake readme_html all -pm=Docs::Site_SVD::File_PM2File

=back

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