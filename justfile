[private]
default:
  @just --justfile "{{justfile()}}" --list

install-hooks:
  pre-commit install

docker-build:
   docker build --quiet -t code-maat-app ./code-maat

alias m := maat
maat *args: docker-build
  docker run --rm -v $PWD:/cm code-maat-app {{args}}

alias mg := maat-git
maat-git *args:
  just maat -l /cm/logfile.log -c git2 {{args}}

generate-git-log dir after:
  cd {{dir}} && \
  git log --all --numstat --date=short --pretty=format:'--%h--%ad--%aN' --no-renames --after={{after}} > {{invocation_directory()}}/logfile.log

cloc dir output:
  cd {{dir}} && \
  cloc ./ --unix --by-file --csv --quiet --report-file={{invocation_directory()}}/{{output}}%
