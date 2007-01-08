#! /usr/bin/perl

=pod

=head1 NAME

B<prepare_for_cd> - a GPW author kit utility to make PPCD files from a contribution

=head1 VERSION

This manual describes version 0.04.

=head1 SYNOPSIS

Call

 prepare_for_cd article_<AUTHORMNEMONIC>.tex

in the main directory of your German Perl Workshop author kit.
Usually this is done automatically by the provided makefile.

=head1 DESCRIPTION



=head1 AUTHORS

Steffen Schwigon, Jochen Stenzel, 2004.

=cut

# declare version
$VERSION=0.04;


# pragmata
use strict;
use warnings;
use locale;

# load modules
use Pod::Usage;
use File::Copy;
use File::NCopy;
use File::Path;
use Unicode::String qw(latin1 utf8);


# check call
pod2usage unless @ARGV == 1 and $ARGV[0] =~ /^article_(\w+).tex$/;
my $filename = $ARGV[0];

# store author shortcut
my $authorMnemonic = $1;
my $goodies_subdir = "goodies_$authorMnemonic";
my $article_subdir = $authorMnemonic;
my $indexlist_file = "indexlist_$authorMnemonic";

# a few declarations
my @authors;
my @converted_article_lines = ();
my @abstract_lines          = ();
my %bio                     = ();
# don't mess around with backslashes!
my $re_title 		    = '^\\\section\s*{(.*)}\s*$';
my $re_head 		    = '^\\\subsection';
my $re_head_bio             = '^\\\subsection\*?\s*{bio\s+(.*)}$';
my $re_head_author 	    = '^\\\subsection\*?\s*{\s*auth?or(s|en)?\s*}';
my $re_head_abstract 	    = '^\\\subsection\*?\s*{\s*abstra[ck]t\s*}';

# slurp in article file
my @article_lines           = <>;

# collect title data
my @title = map {
                 m/$re_title/;
                 $1;
                } grep /$re_title/, @article_lines;

my $title = $title[0];

my $in_bio_section      = 0;
my $in_author_section   = 0;
my $in_abstract_section = 0;
my $cur_bio_name        = '';

# investigate all lines of the original article file
foreach (@article_lines) {
##  next if m/$re_title/; # no title

  # enter/leave AUTHOR/ABSTRACT sections
  if (/$re_head/i and $in_author_section) {
    $in_author_section = 0;
  }
  if (/$re_head/i and $in_abstract_section) {
    $in_abstract_section = 0;
  }
  if (/$re_head/i and $in_bio_section) {
    $in_bio_section = 0;
  }
  if (/$re_head_author/i) {
    $in_author_section = 1;
  }
  if (/$re_head_abstract/i) {
    $in_abstract_section = 1;
  }
  if (/$re_head_bio/i) {
    $in_bio_section = 1;
    $cur_bio_name = $1;
    $cur_bio_name =~ s/^\s+//;
    $cur_bio_name =~ s/\s+$//;
  }
  # don't use (some) headlines
  if (/$re_head_author/i) {
    # no next;
  }
  if (/$re_head_abstract/i) {
    # no next;
  }
  if (/$re_head_bio/i) {
    next;
  }
  # author content
  if ($in_author_section and not /$re_head_author/i) {
    my $authorline = $_;
    # get author name
    $authorline =~ s/\\\w.*<+.+>+.*//g; # cut email addresses, incl. possible pod markup
    $authorline =~ s/[()<>,;]//g;       # cut email addresses, incl. possible pod markup
    $authorline =~ s/^\s+//;
    $authorline =~ s/\s+$//;
    push @authors, $authorline if $authorline;
    # no next;
  }
  # bio content
  if ($in_bio_section) {
    $bio{$cur_bio_name} .= $_ unless $_ =~ /$re_head_bio/i;
    next;
  }
  # abstract content
  if ($in_abstract_section) {
    push @abstract_lines, $_ unless $_ =~ /$re_head_abstract/i;
  }
  # reduce headline depth
  #  -> not done in latex
  push @converted_article_lines, $_;
}
# get author 
my $author = join (', ', @authors);

# build title and author directory names
my $pp_title  = str2ppcd_filename ($title);
my $pp_author = str2ppcd_filename ($author);

# anything to do?
if ($pp_title and $pp_author) {

  # build directory names
  my $outdir        = "ws_ppcd";
  my $outdir_bios   = "$outdir/bios";
  my $outdir_talk   = "$outdir/talk";
  my $outdir_author = "$outdir_talk/$pp_author";
  my $outdir_title  = "$outdir_author/$pp_title";
  my $talk_file     = "$outdir_title/talk.tex";
  my $abstract_file = "$outdir_title/abstract.tex";

  # make directories
  mkpath ($outdir)        unless -d $outdir;
  mkpath ($outdir_author) unless -d $outdir_author;
  mkpath ($outdir_title)  unless -d $outdir_title;

  # write talk file
  open TALKFILE, "> $talk_file" or die "Cannot open $talk_file";
  print TALKFILE @converted_article_lines;
  close TALKFILE;

  # write abstract file, if necessary
  if (@abstract_lines) {
    open ABSTRACTFILE, "> $abstract_file" or die "Cannot open $abstract_file";
    print ABSTRACTFILE @abstract_lines;
    close ABSTRACTFILE;
  }

  # copy images and goodies as necessary
  my $ncopy = new File::NCopy (recursive => 1);
  $ncopy->copy ($article_subdir, $outdir_title) if -d $article_subdir;
  mkpath ("$outdir_title/data"), $ncopy->copy ("$goodies_subdir/*", "$outdir_title/data") if <$goodies_subdir/*>;

  # copy index list, if any
  File::Copy::copy ($indexlist_file, "$outdir_title/talk-index") if -e $indexlist_file;

  # copy author bio, if any
  foreach my $bio_name (keys %bio) {
    my $pp_bio_name  = str2ppcd_filename ($bio_name);
    my $bio_dir      = "$outdir_bios/$pp_bio_name";
    my $bio_filename = "$bio_dir/author.tex";
    mkpath ($bio_dir) unless -d $bio_dir;
    open BIOFILE, "> $bio_filename" or die "Cannot open $bio_filename";
    print BIOFILE $bio{$bio_name};
    close BIOFILE;
  }
}


# FUNCTIONS #########################################

sub str2ppcd_filename {
  my $str =  shift;
  $str 	=~ s/^\s+//;
  $str 	=~ s/\s+$//;
  $str 	=~ s/\s/_/g;
  my $utf8_str = latin1($str)->utf8;
  return $utf8_str;
}

