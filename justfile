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
  @mkdir -p out
  cd {{dir}} && \
  git log --all --numstat --date=short --pretty=format:'--%h--%ad--%aN' --no-renames --after={{after}} > {{invocation_directory()}}/out/logfile.log

cloc dir output:
  @mkdir -p out
  cd {{dir}} && \
  cloc ./ --unix --by-file --csv --quiet --report-file={{invocation_directory()}}/out/{{output}}

# Code Maat Analysis

analysis type logfile *args:
  just mg {{logfile}} -a {{type}} {{args}}

all-analysis logfile *args:
  #!/bin/bash
  types=(abs-churn age author-churn authors communication coupling entity-churn entity-effort entity-ownership fragmentation identity main-dev main-dev-by-revs refactoring-main-dev revisions soc summary)
  for type in "${types[@]}"
  do
    just analysis "$type" {{logfile}} -o "out/$type.csv" {{args}} || break
  done
