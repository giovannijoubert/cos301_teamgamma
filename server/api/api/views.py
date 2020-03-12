from django.shortcuts import render
from django.http import HttpResponse, HttpResponseForbidden, HttpResponseNotFound, JsonResponse
import hashlib

jsonObj = ""

def robots_txt(request):
    # Block search engine indexing
    return HttpResponse("User-Agent: *\nDisallow: /", content_type="text/plain")

# GAMMA API
def echo_api(request, user_txt):
    # docs: https://docs.djangoproject.com/en/3.0/ref/request-response/
    # Demo API to output URL string
    return JsonResponse({'user_input': user_txt, 'request': request.method, 'server': request.META.get("SERVER_NAME"), 'ip': request.META.get("REMOTE_ADDR")})

def validateJSON(request):
    # TODO: Send data to neural network
    if request.method == 'POST' and request.META.get("SERVER_NAME") == "ai.teamgamma.ga":
        if request.POST.get("checksum", None) != None and request.POST.get("sounddata", None) != None:
            data_test = hashlib.md5(request.POST.get("sounddata", None).encode())
            if data_test == request.POST.get("checksum", None):
                # Send data to neural network
                jsonObj = request.POST.get("sounddata", None)
                return JsonResponse({'result': 'Ok'})
            else:
                return JsonResponse({'result': 'Invalid Checksum'})
        else:
            return JsonResponse({'result': 'Invalid Request'})
    else:
        return JsonResponse({'result': 'Bad Request'})

def postJSON():
    f = open("spectrograph.json","w+")
    for i in range(0,1):
        # todo: Loop through json object and write correctly to file
        f.write("Appended line %d\r\n" % (i+1))
        f.close() 