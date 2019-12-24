# daino

[![Gem Version](https://badge.fury.io/rb/daino.svg)](https://badge.fury.io/rb/daino)
[![Build Status](https://travis-ci.com/ninoseki/daino.svg?branch=master)](https://travis-ci.com/ninoseki/daino)
[![CodeFactor](https://www.codefactor.io/repository/github/ninoseki/daino/badge)](https://www.codefactor.io/repository/github/ninoseki/daino)
[![Coverage Status](https://coveralls.io/repos/github/ninoseki/daino/badge.svg?branch=master)](https://coveralls.io/github/ninoseki/daino?branch=master)

daino(`大脳`) is a dead simple [Cortex](https://github.com/TheHive-Project/Cortex) API wrapper for Ruby.

## Installation

```bash
gem install daino
```

## Usage

```ruby
require "daino"

# when given nothing, it tries to load your API key from ENV["CORTEX_API_KEY"] & API endpoint from ENV["CORTEX_API_ENDPOINT"]
api = Daino::API.new
# or you can set them manually
api = Daino::API.new(api_endpoint: "http://your_api_endpoint", api_key: "yoru_api_key")

# search jobs
jobs = api.job.search(data: "1.1.1.1", data_type: "ip")

jobs.each do |job|
  id = job.dig("id")
  next unless id

  # get a report of a job
  report = api.job.report(id)
  puts JSON.pretty_generate(report)
end
```

## Implemented methods

### Analyzer

| HTTP Method | URI                           | Action                | API method                                                                                                                                                                                                     |
|-------------|-------------------------------|-----------------------|----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| GET         | /api/analyzer                 | List analyzers        | `#api.analyzer.list`                                                                                                                                                                                           |
| POST        | /api/analyzer/_search         | Search analyzers      | `#api.analyzer.search(attributes)`                                                                                                                                                                             |
| GET         | /api/analyzer/:analyzerId     | Get an analyzer       | `#api.analyzer.get_by_id(id)`                                                                                                                                                                                  |
| GET         | /api/analyzer/:analyzerId     | Get an analyzer       | `#api.analyzer.get_by_id(id)` or `#api.analyzer.get_by_name(name)`                                                                                                                                             |
| GET         | /api/analyzer/type/:dataType  | Get analyzers by type | `#api.analyzer.get_by_type(type)`                                                                                                                                                                              |
| POST        | /api/analyzer/:analyzerId/run | Run an analyzer       | `#api.analyzer.run_by_id(id, data:, data_type:, tlp: 0, message: nil, parameters: nil, force: nil)` or `#api.analyzer.run_by_name(name, data:, data_type:, tlp: 0, message: nil, parameters: nil, force: nil)` |

### Job

| HTTP Method | URI                       | Action                 | API method                      |
|-------------|---------------------------|------------------------|---------------------------------|
| POST        | /api/job/_search          | Search jobs            | `#api.job.search(range: "all")` |
| GET         | /api/job/:jobId           | Get a job by id        | `#api.job.get_by_id(id)`        |
| GET         | /api/job/:jobId/report    | Get a report of a job  | `#api.job.report(id)`           |
| GET         | /api/job/:jobID/artifacts | Get artifacts of a job | `#api.job.artifacts(id)`        |
| DELETE      | /api/job/:jobId           | Delete a job           | `#api.job.delete_by_id(id)`     |

### Organization

| HTTP Method | URI                                    | Action                       | API method                                                        |
|-------------|----------------------------------------|------------------------------|-------------------------------------------------------------------|
| GET         | /api/organization                      | List organizations           | `#api.organization.list`                                          |
| POST        | /api/organization/_search              | Search organizations         | `#api.organization.search(attributes)`                            |
| GET         | /api/organization/:organizationId      | Get an organization          | `#api.organization.get_by_id(id)`                                 |
| GET         | /api/organization/:organizationId/user | Get users of an organization | `#api.organization.users(id)`                                     |
| POST        | /api/organization                      | Create an organization       | `#api.organization.create(name:, description:, status: "Active")` |
| DELETE      | /api/organization/:organizationId      | Delete an organization       | `#api.organization.delete_by_id(id)`                              |

### User

| HTTP Method | URI                 | Action        | API method                                                             |
|-------------|---------------------|---------------|------------------------------------------------------------------------|
| GET         | /api/user           | List users    | `#api.user.list`                                                       |
| POST        | /api/user/_search   | Search users  | `#api.user.search(attributes)`                                         |
| GET         | /api/user/:userName | Get a user    | `#api.user.get_by_name(name)`                                          |
| POST        | /api/user           | Create a user | `#api.user.create(name:, roles:, organization:, login:, status: "Ok")` |

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
