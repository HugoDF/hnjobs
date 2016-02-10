require 'open-uri'
require 'json'
require 'nokogiri'
class HNJobs
    BASE_URL = "https://hacker-news.firebaseio.com/v0/"
    JOBS_URL =  BASE_URL + "jobstories.json"
    def initialize
        @jobs = Array.new
        open(JOBS_URL){|f|
            f.each_line do |line|
                raw = line
                unless raw.nil?
                    data = JSON.parse(raw)
                    data.each do |id|
                        job_url = BASE_URL + "item/#{id}.json"
                        open(job_url){|d|
                            d.each_line do |job_line|
                                unless job_line.nil?
                                    job = JSON.parse(job_line)
                                    job["text"] = Nokogiri::HTML(job["text"]).text
                                    @jobs << job
                                end
                            end
                        }
                    end
                end
            end
        }
    end
    def jobs
        @jobs
    end
end