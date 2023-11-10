# frozen_string_literal: true

require "bundler/gem_tasks"
require "rspec/core/rake_task"

RSpec::Core::RakeTask.new(:spec)

task default: :spec

desc "List out API Routes"
task(:routes) do
  require 'open_ai/client'
  require 'terminal-table'

  directory         = OpenAi::Client.directory
  route_definitions = OpenAi::Client.routes

  row_display = ->(row,index) do
    [(index + 1), row.name, row.href_value, row.name]
  end

  title    = "%s (%s)" % [directory.title, route_definitions.count]
  headings = ['#', 'Route Name', 'URL', 'Rel']
  rows     = route_definitions.each_with_index.map { |r,i| row_display.call(r,i) }

  table = Terminal::Table.new(title: title, headings: headings, rows: rows)
  puts "\n"
  puts table.to_s
  puts "\n"
end
