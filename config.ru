# frozen_string_literal: true

require ::File.expand_path('../config/environment', __FILE__)

require 'unicorn/worker_killer'

max_request_min =  3072
max_request_max =  4096
use Unicorn::WorkerKiller::MaxRequests, max_request_min, max_request_max

oom_min = (192 * (1024**2))
oom_max = (256 * (1024**2))
use Unicorn::WorkerKiller::Oom, oom_min, oom_max

run Rails.application
