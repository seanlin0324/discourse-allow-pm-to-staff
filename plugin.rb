# name: allow-pms-to-staff
# about: Allow pms to staff even if PMs are otherwise not allowed
# version: 0.2
# authors: pfaffman

after_initialize do
  add_to_class('guardian', :can_send_private_message?) do |target, notify_moderators: false|
    target.is_a?(User) &&
      # User is authenticated
      authenticated? &&
      # Have to be a basic level at least
      (target.staff? || @user.has_trust_level?(SiteSetting.min_trust_to_send_messages) || notify_moderators) &&
      # User disabled private message
      (target.staff? || is_staff? || target.user_option.allow_private_messages) &&
      # PMs are enabled
      (target.staff? || is_staff? || SiteSetting.enable_personal_messages || notify_moderators)
  end
end

