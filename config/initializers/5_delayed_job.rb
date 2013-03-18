# Always send jobs to queue, some worker will run those later
Delayed::Worker.delay_jobs = true
