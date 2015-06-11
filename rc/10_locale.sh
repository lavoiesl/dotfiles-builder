#!/bin/bash

locales="$(locale -a)"

language=en
country=US
charset="UTF-?8"

locale=$(locale -a | sort -r | grep -iE "${language}(_${country}(\.${charset})?)?$" | head -n1)

if [[ -z "${locale}" ]]; then
  locale=C
fi

for var in LANG LANGUAGE LC_ALL; do
  echo_export_single_quote "${var}" "${locale}"
done

if [[ "${locale}" =~ UTF-?8 ]]; then
  echo_export_single_quote LESSCHARSET 'UTF-8'
fi
