Fabricator(:subscription) do
  paid { false }
  paid_on { nil }
  amount_charged { nil }
  stripe_token { nil }
end