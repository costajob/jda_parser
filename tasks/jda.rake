require "./lib/jda/parser"

namespace :jda do
  desc "Create a report by reading JDA files into the specified folder (default to root=/jda), by filtering basing on skus, stores and MD flag"
  task :report do
    files = Dir["#{ENV.fetch("root", "/jda")}/*"]
    parser = Jda::Parser::new(files: files)
    skus = ENV.fetch("skus", "").split(",").map!(&:strip)
    stores = ENV.fetch("stores", "").split(",").map!(&:strip)
    md_flag = !!ENV["md_flag"]
    puts "Filtering data of #{files.size} feeds on:"
    puts "\t skus: #{skus.inspect}"
    puts "\t stores: #{stores.inspect}"
    puts "\t md_flag: #{md_flag.inspect}"
    parser.filter!(skus: skus, stores: stores, md_flag: md_flag)
    parser.report
    puts "Reports generated into: #{File.expand_path("../..", __FILE__)}/reports"
  end
end