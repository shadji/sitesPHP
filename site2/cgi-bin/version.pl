#!/usr/bin/perl
# Available under BSD License.
# See url http://www.cyberciti.biz/faq/how-can-i-find-out-perl-version/

use POSIX;
use CGI;

$cgi = CGI->new;
$id = $cgi->param('id');

print $cgi->header();

$command=`perl -v`;
$title = "Perl Version";
 

 
print "<h1>$title</h1>\n";
 
print '&lt;pre>';
print $command;
print '&lt;/pre>';
 
print "</body></html>";
