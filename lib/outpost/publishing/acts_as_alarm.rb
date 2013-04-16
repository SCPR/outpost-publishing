module Outpost
  module Publishing
    module ActsAsAlarm
      extend ActiveSupport::Concern

      included do
        scope :pending, -> { where("fire_at <= ?", Time.now).order("fire_at") }
        belongs_to :content, polymorphic: true
      end


      module ClassMethods
        #---------------------
        # Fire any pending alarms
        def fire_pending
          self.pending.each do |alarm|
            alarm.fire
          end
        end
      end


      #---------------------
      # Fire an alarm.
      def fire
        return false unless self.can_fire?

        if self.content.update_attributes(status: Outpost::Publishing.status_published)
          self.destroy
        else
          false
        end
      end

      #---------------------

      def pending?
        self.fire_at <= Time.now
      end

      #---------------------
      # Can fire if this alarm is pending, and if the content is 
      # Pending -OR- Published... in the case that it's published, 
      # it will just serve to "touch" the content.
      #
      # Note that SCPRv4 destroys content alarms when content moves 
      # from Pending -> Not Pending, so once mercer is gone, there 
      # shouldn't be any alarms with content that ISN'T Pending,
      # so the extra `content.published?` condition can probably
      # go away at that point.
      def can_fire?
        self.pending? && (self.content.pending? || self.content.published?)
      end
    end
  end
end
