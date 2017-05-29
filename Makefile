NAMESPACE = diamond5170
IMAGENAME = monitorrent
PORT = 6687

.PHONY: download build run stop start rmf rmi

build:
	docker rmi -f $(NAMESPACE)/$(IMAGENAME):bak || true
	docker tag $(NAMESPACE)/$(IMAGENAME) $(NAMESPACE)/$(IMAGENAME):bak || true
	docker rmi -f $(NAMESPACE)/$(IMAGENAME) || true
	docker build -t $(NAMESPACE)/$(IMAGENAME) .

run:
	docker rm $(IMAGENAME) || true
	docker run -d -p $(PORT):$(PORT) $(NAMESPACE)/$(IMAGENAME)

stop:
	docker stop $(IMAGENAME)

start:
	docker start $(IMAGENAME)


rmf:
	docker rm -f $(IMAGENAME)


rmi:
	docker rmi $(NAMESPACE)/$(IMAGENAME)


rmibak:
	docker rmi $(NAMESPACE)/$(IMAGENAME):bak


tag:
	docker tag $(NAMESPACE)/$(IMAGENAME) $(NAMESPACE)/$(IMAGENAME):latest


push:
	docker push $(NAMESPACE)/$(IMAGENAME)