job1 = Job.create(title: "Software Engineer", description: "We are looking for a talented Software Engineer to join our team.")
job2 = Job.create(title: "Product Manager", description: "Exciting opportunity for a Product Manager to shape our product roadmap.")
job3 = Job.create(title: "Data Analyst", description: "We need a skilled Data Analyst to help us make data-driven decisions.")
job4 = Job.create(title: "UI/UX Designer", description: "Join our design team and create exceptional user experiences.")

application1 = Application.create(candidate_name: "John Doe", job: job1)
application2 = Application.create(candidate_name: "Jane Smith", job: job2)
application3 = Application.create(candidate_name: "Michael Johnson", job: job3)
application4 = Application.create(candidate_name: "Emily Davis", job: job4)
application5 = Application.create(candidate_name: "David Wilson", job: job1)

Job::Event::Activate.create(job: job1)
Job::Event::Activate.create(job: job2)
Job::Event::Activate.create(job: job3)
Job::Event::Activate.create(job: job4)
Job::Event::Deactivate.create(job: job3)

Application::Event::Interview.create(application: application1, interview_date: 1.week.ago)
Application::Event::Reject.create(application: application1)

Application::Event::Interview.create(application: application2, interview_date: 1.week.ago)
Application::Event::Hire.create(application: application2, hire_date: 1.day.ago)
Application::Event::Note.create(application: application2, content: 'Will start working in one month')

Application::Event::Note.create(application: application3, content: 'Job was deactivated')

Application::Event::Interview.create(application: application4, interview_date: Date.yesterday)

Application::Event::Note.create(application: application5, content: 'We have to schedule interview')
Application::Event::Interview.create(application: application5, interview_date: 2.weeks.ago)
Application::Event::Hire.create(application: application5, hire_date: 3.days.ago)


