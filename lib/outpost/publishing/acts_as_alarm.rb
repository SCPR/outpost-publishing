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
      # Fire an alarm. You should override this.
      def fire
        return false unless self.can_fire?
        puts "Fired."
        true
      end

      #---------------------

      def pending?
        self.fire_at <= Time.now
      end

      #---------------------
      # You should override this.
      def can_fire?
        self.pending?
      end
    end
  end
end
