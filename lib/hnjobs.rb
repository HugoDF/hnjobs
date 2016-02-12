require 'json'
require 'nokogiri'
require 'net/http'
class HNJobs
    BASE_URL = "https://hacker-news.firebaseio.com/v0/"
    JOBS_URL =  BASE_URL + "jobstories.json"
    def initialize
        @jobs = Array.new
        uri = URI(JOBS_URL)
        ids = JSON.parse(Net::HTTP.get(uri))
        ids.each do |id|
            job_uri = URI(BASE_URL + "item/#{id}.json")
            job = JSON.parse(Net::HTTP.get(job_uri))
            job["text"] = Nokogiri::HTML(job["text"]).text
            @jobs << job
        end
    end
    attr_reader :jobs
end