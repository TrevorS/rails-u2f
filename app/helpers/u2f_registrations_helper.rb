module U2fRegistrationsHelper
  def registration_requests_data(requests)
    content_tag(:div, nil, id: 'registrationRequests', data: { requests: requests.to_json })
  end

  def sign_requests_data(requests)
    content_tag(:div, nil, id: 'signRequests', data: { requests: requests.to_json })
  end
end
