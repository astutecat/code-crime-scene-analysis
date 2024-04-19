[private]
default:
  @just --justfile "{{justfile()}}" --list

install-hooks:
  pre-commit install

docker-build:
   docker build --quiet -t code-maat-app ./code-maat

alias m := maat
maat *args:
   java -jar bin/code-maat.jar {{args}}

alias mg := maat-git
maat-git logfile *args:
  just maat -l {{logfile}} -c git2 {{args}}

generate-git-log dir after="1970-01-01":
  cd {{dir}} && \
  git log --all --numstat --date=short --pretty=format:'--%h--%ad--%aN' --no-renames --after={{after}} > {{invocation_directory()}}/logfile.log

cloc dir output:
  cd {{dir}} && \
  cloc ./ --unix --by-file --csv --quiet --report-file={{invocation_directory()}}/{{output}}

# Code Maat Analysis

analysis type logfile *args:
  just mg {{logfile}} -a {{type}} {{args}}

abs-churn logfile *args:
  just mg {{logfile}} -a abs-churn {{args}}

age logfile *args:
  just mg {{logfile}} -a age {{args}}

author-churt logfile *args:
  just mg {{logfile}} -a author-churt {{args}}

authors logfile *args:
  just mg {{logfile}} -a authors {{args}}

communication logfile *args:
  just mg {{logfile}} -a communication {{args}}

coupling logfile *args:
  just mg {{logfile}} -a coupling {{args}}

entity-churn logfile *args:
  just mg {{logfile}} -a entity-churn {{args}}

entity-effort logfile *args:
  just mg {{logfile}} -a entity-effort {{args}}

entity-ownership logfile *args:
  just mg {{logfile}} -a entity-ownership {{args}}

fragmentation logfile *args:
  just mg {{logfile}} -a fragmentation {{args}}

identity logfile *args:
  just mg {{logfile}} -a identity {{args}}

main-dev logfile *args:
  just mg {{logfile}} -a main-dev {{args}}

main-dev-by-revs logfile *args:
  just mg {{logfile}} -a main-dev-by-revs {{args}}

messages logfile *args:
  just mg {{logfile}} -a messages {{args}}

refactoring-main-dev logfile *args:
  just mg {{logfile}} -a refactoring-main-dev {{args}}

revisions logfile *args:
  just mg {{logfile}} -a revisions {{args}}

soc logfile *args:
  just mg {{logfile}} -a soc {{args}}

summary logfile *args:
  just mg {{logfile}} -a summary {{args}}
