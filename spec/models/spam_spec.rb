# coding: utf-8

require 'spec_helper'

describe Cleanweb::Spam do
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