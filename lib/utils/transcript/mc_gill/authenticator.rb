module Utils::Transcript
  module McGill
    class AuthenticationError < StandardError

    end

    class Authenticator
      def self.login_url
        'https://horizon.mcgill.ca/pban1/twbkwbis.P_WWWLogin'
      end
      def self.transcript_url
        'https://horizon.mcgill.ca/pban1/bzsktran.P_Display_Form?user_type=S&tran_type=V'
      end

      def self.retrieve_transcript(email, password)
        authenticator = Authenticator.new
        authenticator.login(email, password)
        authenticator.fetch_transcript_html
      end

      def initialize()
        @agent = Mechanize.new
      end

      def login(email, password)
        # Go to login page
        login_page = @agent.get(Authenticator::login_url)

        # Find and fill login form
        form = login_form(login_page)
        form['sid'] = email
        form['PIN'] = password

        submit_login_form(form)
      end

      def login_form(page)
        if form = page.form('loginform1')
          puts form
          form
        else
          raise AuthenticationError.new('Login form not found')
        end
      end

      def submit_login_form(form)
        page = form.submit
        body = page.body

        unless body.match(/Welcome,\+(.*),\+to\+Minerva/)
          if body.include?('Authorization Failure')
            raise AuthenticationError.new('Invalid email or password')
          else
            raise AuthenticationError.new('Authentication failed')
          end
        end
      end

      def fetch_transcript_html
        page = @agent.get(Authenticator.transcript_url)
        page.body
      end
    end
  end
end