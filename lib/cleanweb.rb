# coding: utf-8

require 'net/http'
require 'rexml/document'
require 'open-uri'

class Cleanweb
  require 'cleanweb/version'
  require 'cleanweb/spam'

  include Version
  include Spam

  class KeyError < StandardError; end
  class NoSubjectError < StandardError; end
  class NoBodyError < StandardError; end

  SPAM_URL = "http://cleanweb-api.yandex.ru/1.0/check-spam"

  class << self
    attr_accessor 'api_key'
  end
  @@api_key = nil

  def self.api_key= key
    @@api_key = key
  end

  def initialize params
    check_key
    @params = params
    check_params
  end

  def check_key
    raise KeyError if @@api_key.nil?
  end

  def check_params
    check_subject
    check_body
  end

  def check_subject
    @subject = @params[:subject]
    raise NoSubjectError if @subject.nil?
  end

  def check_body
    @body = @params[:body]
    raise NoBodyError if @body.nil?
  end

end
