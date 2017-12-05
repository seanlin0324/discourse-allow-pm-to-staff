# name: allow-pms-to-staff
# about: Allow pms to staff even if PMs are otherwise not allowed
# version: 0.1
# authors: pfaffman

after_initialize do
  add_to_class('guardian', :can_send_private_message?) do |target|
    target.is_a?(User) &&
    # User is authenticated
    authenticated? &&
    # Have to be a basic level at least
    @user.has_trust_level?(SiteSetting.min_trust_to_send_messages) &&
    # User disabled private message
    (is_staff? || target.user_option.allow_private_messages) &&
    # PMs are enabled
    (is_staff? || SiteSetting.enable_private_messages) &&
    # Can only send pms to staff
    target.staff?
  end
end
