require 'ostruct'
require 'coursewareable'

# Courseware configuration entries
module CoursewareAPI
  mattr_accessor :config
end

CoursewareAPI.config = Coursewareable.config
%w(domain_name default_email_address support_email_address).each do |member|
  CoursewareAPI.config.new_ostruct_member(member)
end

CoursewareAPI.config.domain_name = 'api.coursewa.re'
CoursewareAPI.config.default_email_address = 'no-reply@coursewa.re'
CoursewareAPI.config.support_email_address = 'help@coursewa.re'
