# Covid PT discord bot

**UPDATE: Most COVID API are borked because of the lack of standards on government updates. Also updates are now weekly. I will stop mantaining this because of these inconsistencies.**

A discord bot powered by Fernando's [covid_pt library](https://github.com/frm/covid_pt).

This bot fetches numbers about the current COVID-19 pandemic on Portugal. Reports are fetched from a government website. Check them [here](https://covid19.min-saude.pt/relatorio-de-situacao/).

Check the [bot's website](https://discord-covid-pt.herokuapp.com/) for info.

## Pre-requisites

Make sure you have `ruby 2.7.1` and that's it. The `bin/setup` script will use `asdf` if it's available. I recommend it. Any other ruby version manage will work.

## Scripts

`bin/setup` runs the setup.

`bin/server` starts the development server.

`bin/lint` runs the linter.

## Github Actions

By default `rubocop` is running in Github Actions. This is for my own sake. After cloning this repo for your projects, feel free to delete it. If you want to disable the Github Actions, just delete the `.github` folder.

## Contributing

Issues are welcome. PRs are welcome. Be nice.

You can reach me via email at [francisco.sousa@hey.com](mailto:francisco.sousa@hey.com) for any specific question.
