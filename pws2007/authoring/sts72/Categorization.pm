package Lamebrain::Categorization;

use strict;
use warnings;

use Lamebrain::Class;
use base 'Lamebrain::Class';

sub pre_init  {
  my $self   = shift;
  $self->SUPER::pre_init (@_);
  $self->lockfile ('/tmp/lamebrain_categorization.lck');
  $self->verbose (1);
}

sub learn {
  my $self = shift;

  return unless $self->lock;
  my $ds = new LibCPV::Categorizer::DocumentSet
   ({
     show_stats           => $self->dsopts_show_stats,
     filter_min_cpvs      => $self->dsopts_filter_min_cpvs,
     filter_max_cpvs      => $self->dsopts_filter_max_cpvs,
     filter_load_offset   => $self->dsopts_filter_load_offset,
     filter_load_max_docs => $self->dsopts_filter_load_max_docs
    });
  $ds->add_docs_from_dir ($self->opts_learner_docdir);

  my $l = new LibCPV::Categorizer
   ({
     document_set         => $ds,
     learner_rootdir      => $self->opts_learner_rootdir,
     max_docs_per_learner => $self->opts_max_docs_per_learner,
     ks_params            => {
                              tfidf_weighting =>
                              $self->ksopts_tfidf_weighting,

                              features_kept   =>
                              $self->ksopts_features_kept
                             },
     learner_params       => {
                              threshold       =>
                              $self->learneropts_threshold
                             },
     learner_class        => $self->opts_learner_class
    });
  if ($self->clean_before_learn) {
    my $cmd =
     'rm -fr '.
      $self->opts_learner_rootdir.'/'.$self->opts_learner_class;
    print STDERR $cmd."\n" if $self->verbose;
    system ($cmd);
  }
  print STDERR "Learn, Forrest, learn ...!\n" if $self->verbose;
  $l->train;
  $self->unlock;
}

1;
