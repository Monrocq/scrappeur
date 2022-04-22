require_relative '../lib/mairie'

describe 'the main app' do
    it 'not have errors' do
        expect(perform).to_not be nil
    end
end

describe 'the result of main app' do
    it 'have more than 3 key|value' do
        expect(perform.length).to be > 3
    end
end

