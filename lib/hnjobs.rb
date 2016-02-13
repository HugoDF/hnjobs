require 'json'
require 'nokogiri'
require 'net/http'
require 'thread'

class HNJobs
    BASE_URL = "https://hacker-news.firebaseio.com/v0/"
    JOBS_URL =  BASE_URL + "jobstories.json"
    attr_reader :jobs
    def initialize
        @jobs = Array.new
        uri = URI(JOBS_URL)
        ids = JSON.parse(Net::HTTP.get(uri))
        @jobs = get_jobs ids
    end
    private
    def get_jobs ids
        mutex = Mutex.new
        threads = Array.new
        jobs = Array.new
        ids.each do |id|
            threads << Thread.new(id, jobs) do |id, jobs|
                job_uri = URI(BASE_URL + "item/#{id}.json")    
                job = JSON.parse(Net::HTTP.get(job_uri))
                job["text"] = Nokogiri::HTML(job["text"]).text
                mutex.synchronize{ jobs << job}
            end
        end
        threads.each(&:join)
        jobs
    end
end