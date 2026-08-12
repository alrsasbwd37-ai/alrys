FROM python:3.10-slim

RUN apt update && apt install -y git

# clone your fork
RUN git clone https://github.com/alrsasbwd37-ai/alrys.git /root/Arab

WORKDIR /root/Arab

RUN pip3 install --no-cache-dir -r requirements.txt

ENV PATH="/home/Arab/bin:$PATH"

CMD ["python3","-m","Arab"]
