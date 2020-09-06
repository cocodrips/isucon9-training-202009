.PHONY: frontend webapp payment bench

all: frontend webapp payment bench

frontend:
	cd webapp/frontend && make
	cd webapp/frontend/dist && tar zcvf ../../../ansible/files/frontend.tar.gz .

webapp:
	tar zcvf ansible/files/webapp.tar.gz \
	--exclude webapp/frontend \
	webapp

payment:
	cd blackbox/payment && make && cp bin/payment_linux ../../ansible/roles/benchmark/files/payment

bench:
	cd bench && make && cp -av bin/bench_linux ../ansible/roles/benchmark/files/bench && cp -av bin/benchworker_linux ../ansible/roles/benchmark/files/benchworker



LANGUAGE:=python
build:
	docker-compose -f webapp/docker-compose.local.yml -f webapp/docker-compose.$(LANGUAGE).yml build
run-local: build
	docker-compose -f webapp/docker-compose.local.yml -f webapp/docker-compose.$(LANGUAGE).yml up
remove:
	docker-compose -f webapp/docker-compose.local.yml -f webapp/docker-compose.$(LANGUAGE).yml rm

profile:
	wlreporter -f /tmp/profile.log
	cat /tmp/profile.log_summary_data.log

SUMMARY:=/tmp/summary.txt
deploy:
	 cd ansible && ansible-playbook -i remote deploy_app.yml && ansible-playbook -i remote deploy_db.yml && cd -

# cleanup
clean:
	cd ansible && ansible-playbook -i remote clean.yml && cd -

summary:
	cd ansible && ansible-playbook -i remote summary.yml && cd -
	find /tmp/ -name alp.txt | xargs cat > $(SUMMARY)
	curl -F file=@$(SUMMARY) -F "initial_comment=alp result" -F channels=isucon10 -H "Authorization: Bearer $(ISUCON10_SLACK_TOKEN)" https://slack.com/api/files.upload

	find /tmp/ -name pt-query-digest.txt | xargs cat > $(SUMMARY)
	curl -F file=@$(SUMMARY) -F "initial_comment=slow query result" -F channels=isucon10 -H "Authorization: Bearer $(ISUCON10_SLACK_TOKEN)" https://slack.com/api/files.upload
