require "rails_helper"

module Dttp
  module ContactService
    describe Create do
      let(:trainee) do
        instance_double(Trainee, id: 1, first_names: "Dave", last_name: "Davids", dttp_id: "uuid-id")
      end

      let(:access_token) { "token" }
      let(:endpoint_path) { "/contacts" }
      let(:contactid) { "60f77a42-5f0e-e611-80e0-00155da84c03" }
      let(:headers) do
        {
          "odata-version" => "4.0",
          "odata-entityid" => "https://example.com/api/data/v9.0/contacts(#{contactid})",
        }
      end

      let(:response) { double(body: "", headers: headers) }

      before do
        allow(AccessTokenService).to receive(:call).and_return(access_token)
        allow(trainee).to receive(:update!)
      end

      describe ".call" do
        it "sends the payload to dttp" do
          # TODO: add a presenter to handle the values for the payload and maybe pass that in instead

          body = {
            "firstname" => trainee.first_names,
            "lastname" => trainee.last_name,
          }

          expect(Client).to receive(:post).with(
            endpoint_path,
            hash_including(body: body),
          ).and_return(response)

          described_class.call(trainee: trainee)
        end

        it "sets the headers correctly" do
          headers = {
            "Accept" => "application/json",
            "Content-Type" => "application/json;odata.metadata=minimal",
            "Authorization" => "Bearer #{access_token}",
          }

          expect(Client).to receive(:post).with(
            endpoint_path,
            hash_including(headers: headers),
          ).and_return(response)

          described_class.call(trainee: trainee)
        end

        describe "storing the returned id" do
          context "the id is returned in the odata-entityid header" do
            it "updates the trainee with the returned contactid" do
              expect(Client).to receive(:post).and_return(response)
              expect(trainee).to receive(:update!).with(dttp_id: contactid)

              described_class.call(trainee: trainee)
            end
          end
        end

        context "the header isn't present" do
          let(:headers) { {} }
          it "raises a DttpIdNotReturned error" do
            expect(Client).to receive(:post).and_return(response)
            expect { described_class.call(trainee: trainee) }.to raise_error(DttpIdNotReturnedError)
          end
        end

        context "the header doesn't contain a matching id pattern" do
          let(:contactid) { "dave" }

          it "raises a DttpIdNotReturned error" do
            expect(Client).to receive(:post).and_return(response)
            expect { described_class.call(trainee: trainee) }.to raise_error(DttpIdNotReturnedError)
          end
        end
      end
    end
  end
end