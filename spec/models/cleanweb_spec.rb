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

  context "spam?" do
    let(:params) { {subject: "subject", body: "body"} }
    let(:cleanweb) { Cleanweb.new params }
    let(:ok_response) { File.read(File.join("spec", "mocks", "ok.xml")) }
    let(:links_response) { File.read(File.join("spec", "mocks", "links.xml")) }
    let(:no_links_response) { File.read(File.join("spec", "mocks", "no_links.xml")) }
    let(:no_links_body_response) { File.read(File.join("spec", "mocks", "no_links_body.xml")) }
    let(:body_response) { File.read(File.join("spec", "mocks", "body.xml")) }

    it "возвращает false если контент не спам" do
      cleanweb.should_receive(:ask_yandex).and_return(ok_response)
      expect(cleanweb.spam?).to eq false
    end

    it "возвращает true если контент спам, а ссылки ок" do
      cleanweb.should_receive(:ask_yandex).and_return(body_response)
      expect(cleanweb.spam?).to eq true
    end

    it "возвращает true если контент ок, а ссылки спам" do
      cleanweb.should_receive(:ask_yandex).and_return(links_response)
      expect(cleanweb.spam?).to eq true
    end

    it "возвращает false если контент ок, а ссылкок нет" do
      cleanweb.should_receive(:ask_yandex).and_return(no_links_response)
      expect(cleanweb.spam?).to eq false
    end

    it "возвращает true если контент спам, а ссылкок нет" do
      cleanweb.should_receive(:ask_yandex).and_return(no_links_body_response)
      expect(cleanweb.spam?).to eq true
    end
  end
end