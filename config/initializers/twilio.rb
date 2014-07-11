TWILIO_ACCT_SID = ENV['TWILIO_ACCT_SID']
TWILIO_TOKEN    = ENV['TWILIO_TOKEN']

if TWILIO_ACCT_SID.nil? or TWILIO_TOKEN.nil?
  raise RuntimeError, "Invalid Twilio Account SID and/or API Token"
end

TWILIO = Twilio::REST::Client.new(TWILIO_ACCT_SID, TWILIO_TOKEN)
