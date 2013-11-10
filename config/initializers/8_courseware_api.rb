require 'ostruct'
require 'coursewareable'

# Courseware configuration entries
module CoursewareAPI
  mattr_accessor :config
end

CoursewareAPI.config = Coursewareable.config
CoursewareAPI.config.domain_name = 'api.open.coursewa.re'
CoursewareAPI.config.default_email_address = 'no-reply@open.coursewa.re'
CoursewareAPI.config.support_email_address = 'help@open.coursewa.re'
