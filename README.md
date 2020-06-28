# :seedling: Gardener's World monthly jobs

JSON API for the "What to do now" section of the
[Gardener's World](https://www.gardenersworld.com/) website.

## Usage

The API is a single static JSON file which is hosted on GitHub Pages.

<https://www.chrismytton.uk/gardeners-world-monthly-jobs/jobs.json>

There is a GitHub Actions workflow which rebuilds the API once a day.

I use the API to generate a monthly checklist on my personal Trello board. You
can see the code for that in
[chrismytton/trello-garden-jobs](https://github.com/chrismytton/trello-garden-jobs).

## Development

The scraper is written in Ruby, so you'll need a recent version of that
installed to work on the API locally.

To install, get the code from GitHub and install the dependencies with
[Bundler](https://bundler.io/).

```
$ git clone https://github.com/chrismytton/gardeners-world-monthly-jobs.git
$ cd gardeners-world-monthly-jobs
$ bundle install
```

There are two commands in the `bin/` directory, `jobs_json` and `build_api`. The
`jobs_json` script fetches the jobs from the Gardener's World website and turns
them into JSON. The `build_api` script uses the `jobs_json` script and redirects
the output to `docs/jobs.json`. The `docs/` directory is set to be served by
GitHub Pages, so when the repository is pushed that becomes the live API.
