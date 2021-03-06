module Pomotrap

  module Cmd

    class Runner

      def self.run(args)
        puts Pomotrap::APPLICATION_NAME.red_on_white.bold
        # TODO: pomotrap.yml => user settings
        cli = Pomotrap::Solitaire::PomodoroTechnique.new # TODO fixme: configurable
        options = Pomotrap::Cmd::RunnerOptions.new(args)
        if options[:now]
          display(cli.activities)
        elsif options[:activity]  
          cli.create_activity(options[:activity])
          display(cli.activities)
        elsif options[:pomodoro]
          puts "Prioritizing task #{options[:pomodoro]}".red_on_white
          cli.fire_pomodoro(options[:pomodoro])
          display(cli.activities)
          puts "work in progress.."
        elsif options[:kill]
          puts "Finishing task #{options[:kill]}".red_on_white.bold
          puts "work in progress.."
        else
          puts options.opts
        end
      end

      def self.interrupt
        if options[:activity]  
          options = Pomotrap::Cmd::InterruptionsOptions.new(args)
        end
      end


      def self.display(activities)
        puts "To Do Today : #{Date.today.strftime("%d/%m/%Y")}".red_on_white.bold
        prettify_tasks(activities)
      end

      TASK_FIELDS = %w(description priority pomodoros interruptions)

      def self.prettify_tasks(values)
        values = [values] unless values.is_a?(Array)
        values.each do |value|
          # value["description"] = values[0]
          # value[0] = value[0].split(',')

        end        
        values.view(:class => :table, :fields => TASK_FIELDS)
      end

    end

  end

end
