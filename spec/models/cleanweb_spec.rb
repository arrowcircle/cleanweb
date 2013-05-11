# coding: utf-8

require 'spec_helper'

describe Cleanweb do
  context "initialize" do
    let(:cleanweb_no_key) { Cleanweb.api_key = nil; Cleanweb.new "text"}
    let(:cleanweb_no_subject) { Cleanweb.new no_subject}
    let(:cleanweb_no_body) { Cleanweb.new no_body}

    let(:no_subject) { {subject: nil, body: "body"} }
    let(:no_body) { {subject: "subject", body: nil} }

    it "проверяет наличие ключа" do
      lambda { cleanweb_no_key }.should raise_error(Cleanweb::KeyError)
      Cleanweb.api_key = "123"
    end

    it "проверяет и задает входные параметры" do
      lambda { cleanweb_no_subject }.should raise_error(Cleanweb::NoSubjectError)
      lambda { cleanweb_no_body }.should raise_error(Cleanweb::NoBodyError)
    end
  end
end